//
//  String+SwiftVersion.swift
//  JxSwiftHelper
//
//  Created by Jeanette Müller on 20.11.20.
//

import Foundation

public extension String {
    static func swiftVersion() -> String {
        #if swift(>=6.2)
        return "Swift 6.2"
        #elseif swift(>=6.1)
        return "Swift 6.1"
        #elseif swift(>=6.0)
        return "Swift 6.0"
        #elseif swift(>=5.2)
        return "Swift 5.2"
        #elseif swift(>=5.1)
        return "Swift 5.1"
        #elseif swift(>=5.0)
        return "Swift 5.0"
        #elseif swift(>=4.3)
        return "Swift 4.3"
        #elseif swift(>=4.2)
        return "Swift 4.2"
        #elseif swift(>=4.1)
        return "Swift 4.1"
        #elseif swift(>=4.0)
        return "Swift 4.0"
        #elseif swift(>=3.2)
        return "Swift 3.2"
        #elseif swift(>=3.1)
        return "Swift 3.1"
        #elseif swift(>=3.0)
        return "Swift 3.0"
        #elseif swift(>=2.0)
        return "Swift 2.0"
        #elseif swift(>=1.0)
        return "Swift 1.0"
        #else
        return "Swift unknown"
        #endif
    }
}
