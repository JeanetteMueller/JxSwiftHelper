//
//  PhotoRecord.swift
//  ProjectPhoenix
//
//  Created by Jeanette Müller on 06.10.16.
//  Copyright © 2016 Jeanette Müller. All rights reserved.
//

import UIKit

// This enum contains all the possible states a photo record can be in
public enum PhotoRecordState {
    case new, downloaded, filtered, failed
}

public class PhotoRecord {
    public let path: String
    public let url: URL
    public var state = PhotoRecordState.new
    public var image = UIImage(named: "emerald_fallback")
    
    public var contentMode: UIView.ContentMode = .scaleAspectFit

    public init(url: URL) {
        self.url = url
        self.path = url.absoluteString
    }

    public init?(string: String) {
        if !string.isEmpty, let newUrl = URL(string: string) {
            self.path = string
            self.url = newUrl
        } else {
            return nil
        }
    }

    public func getFilePath() -> String {

    
        let imageDir = FileHelper.shared.getImagesFolderPath()
        
        return imageDir.appending("/").appending(self.url.md5())
    }
}