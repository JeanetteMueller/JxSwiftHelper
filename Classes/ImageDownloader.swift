//
//  ImageDownloader.swift
//  ProjectPhoenix
//
//  Created by Jeanette Müller on 06.10.16.
//  Copyright © 2016 Jeanette Müller. All rights reserved.
//


public class ImageDownloader: Operation {
    //1
    let photoRecord: PhotoRecord

    //2
    public init(photoRecord: PhotoRecord) {
        self.photoRecord = photoRecord
    }

    //3
    public override func main() {

        if self.isCancelled {
            return
        }
        if self.photoRecord.state != .new {
            return
        }

        if self.isCancelled {
            return
        }

        let filename = self.photoRecord.getFilePath()

        if FileManager.default.fileExists(atPath: filename) {
            self.photoRecord.state = .downloaded
            self.photoRecord.image = UIImage(contentsOfFile: filename)
            return
        }

        if let imageData = NSData(contentsOf: self.photoRecord.url) {

            if self.isCancelled {
                return
            }

            if imageData.length > 0 {
                self.photoRecord.image = UIImage(data: imageData as Data)

                imageData.write(toFile: filename as String, atomically: true)
                self.photoRecord.state = .downloaded

                log("load image done")
                return
            }
        } else {
            log("load image failed")
        }

        self.photoRecord.state = .failed

    }
}