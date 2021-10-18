//
//  ImageFiltration.swift
//  ProjectPhoenix
//
//  Created by Jeanette Müller on 06.10.16.
//  Copyright © 2016 Jeanette Müller. All rights reserved.
//

import UIKit


public class ImageFiltration: Operation {
    let photoRecord: PhotoRecord

    init(photoRecord: PhotoRecord) {
        self.photoRecord = photoRecord
    }

    public override func main () {

        let documentsDirectory = FileHelper.shared.getBaseDirectory()

        let imageDir = documentsDirectory.appending("/images")
        let filename = String(format: "%@/%@_filtered", imageDir, self.photoRecord.url.md5())

        if self.isCancelled {
            return
        }

        if self.photoRecord.state != .downloaded {
            return
        }

        if FileManager.default.fileExists(atPath: filename) {
            self.photoRecord.state = .filtered
            self.photoRecord.image = UIImage(contentsOfFile: filename)
            return
        }

        if self.isCancelled {
            return
        }

        if let i = self.photoRecord.image {
            if let filteredImage = self.applySepiaFilter(image: i) {
                if self.photoRecord.state != .downloaded {
                    return
                }

                if let imageData: NSData = filteredImage.pngData() as NSData? {

                    imageData.write(toFile: filename as String, atomically: true)

                    self.photoRecord.image = filteredImage
                    self.photoRecord.state = .filtered
                } else {
                    self.photoRecord.state = .failed
                }
            }
        }
    }

    public func applySepiaFilter(image: UIImage) -> UIImage? {
        if let pngData = image.pngData() {
            let inputImage = CIImage(data: pngData)

            if self.isCancelled {
                return nil
            }
            let context = CIContext(options: nil)
            let filter = CIFilter(name: "CISepiaTone")
            filter?.setValue(inputImage, forKey: kCIInputImageKey)
            filter?.setValue(0.8, forKey: "inputIntensity")
            if let outputImage = filter?.outputImage {

                if self.isCancelled {
                    return nil
                }

                if let outImage = context.createCGImage(outputImage, from: outputImage.extent) {
                    let returnImage = UIImage(cgImage: outImage)
                    return returnImage
                }
            }
        }
        return nil
    }
}