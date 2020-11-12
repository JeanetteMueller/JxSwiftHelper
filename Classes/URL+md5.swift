//
//  URL+md5.swift
//  JxSwiftHelper
//
//  Created by Jeanette Müller on 12.11.20.
//

import Foundation
import CommonCrypto
/*
 You have to add
 #import <CommonCrypto/CommonCrypto.h>
 to your Objective-C Bridging Header File
 */


//ab iOS 13
import CryptoKit // statt CommonCrypto

public extension NSURL {
    // new functionality to add to SomeType goes here
    
    func md5() -> String {
        
        let urlString = self.absoluteString! as String
        
        return urlString.md5()
    }
    
}

public extension URL {
    // new functionality to add to SomeType goes here
    
    func md5() -> String {
        
        let urlString = self.absoluteString as String
        
        return urlString.md5()
    }
    
}
