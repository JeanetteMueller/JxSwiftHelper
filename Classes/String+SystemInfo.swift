//
//  String+SystemInfo.swift
//  JxSwiftHelper
//
//  Created by Jeanette Müller on 20.11.20.
//

import Foundation

public extension String {
    static func systemInfo(_ format: String = "%@ / %@\nBuild %@\n%@ %@ %@\n%@") -> String {
        var currentLang = ""
        if let langs = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String] {
            if let first = langs.first {
                currentLang = "\("Language".localized) \(first)"
            }
        }
        
        if let bundleDict = Bundle.main.infoDictionary {
            var name = ""
            var shortVersion = ""
            var version = ""
            
            if let x = bundleDict[kCFBundleNameKey as String] as? String {
                name = x
            }
            if let x = bundleDict["CFBundleShortVersionString"] as? String {
                shortVersion = x
            }
            if let x = bundleDict["CFBundleVersion"] as? String {
                version = x
            }
            
            return String(format: format,
                          name,
                          shortVersion,
                          version,
                          UIDevice.current.model,
                          UIDevice.current.systemName,
                          UIDevice.current.systemVersion,
                          currentLang
            )
        }
        return "SOMETHING WENT WRONG!"
    }
}
