//
//  FileHelper.swift
//  Podcat 2
//
//  Created by Jeanette Müller on 26.02.17.
//  Copyright © 2017 Jeanette Müller. All rights reserved.
//

import Foundation

open class FileHelper {
    
    public static let shared: FileHelper = {
        
        let instance = FileHelper()
        
        return instance
    }()
    
    init() {
        allFilesCached = NSCache<NSString, NSArray>()
    }
    
    public var securityApplicationGroupIdentifier: String = ""
    
    private var allFilesCached: NSCache<NSString, NSArray>
    public func clearAllFilesCache(_ path: String? = nil) {
        
        if var p = path {
            if !p.hasSuffix("/") {
                p.append("/")
            }
            
            self.allFilesCached.removeObject(forKey: p as NSString)
        }else{
            self.allFilesCached.removeAllObjects()
        }
    }
    public func getAllFiles(_ path: String, withForce force:Bool = false) -> [String] {
        var results = [String]()
        
        var basePath = path
        if !basePath.hasSuffix("/") {
            basePath.append("/")
        }
        
        if !force {
            if let v = self.allFilesCached.object(forKey: basePath as NSString) as? [String] {
                return v
            }
        }
        
        let man = FileManager.default
        
        var basePathIsDir: ObjCBool = false
        if man.fileExists(atPath: basePath, isDirectory: &basePathIsDir) {
            if basePathIsDir.boolValue {
                
                do {
                    let contents = try man.contentsOfDirectory(atPath: basePath)
                    for item in contents {
                        
                        let filePath = "\(basePath)\(item)"
                        
                        var isDir: ObjCBool = false
                        if man.fileExists(atPath: filePath, isDirectory: &isDir) {
                            
                            results.append(filePath)
                            
                            if isDir.boolValue {
                                results.append(contentsOf: self.getAllFiles(filePath))
                            }
                        }
                    }
                    
                } catch let error as NSError {
                    log("🛑 getDownloaded fromPath ERROR: ", error.localizedDescription)
                }
            }
        }
        print("getAllFiles \(path) results \(results)")
        
        self.allFilesCached.setObject(results as NSArray, forKey: basePath as NSString)
        
        return results
    }
    public func urlIsMediaFile(_ url: URL) -> Bool {
        let fileextensions = ["aac", "ac3", "aif",
                              "aiff", "aifc", "caf",
                              "mp3", "mp4", "m4a", "m4b", "m4v", "mov", "wav"]
        return fileextensions.contains(url.pathExtension.lowercased())
    }
    public func urlIsVideoFile(_ url: URL) -> Bool {
        let fileextensions = ["mp4", "m4v", "mov"]
        return fileextensions.contains(url.pathExtension.lowercased())
    }
    public func urlIsOPMLFile(_ url: URL) -> Bool {
        let fileextensions = ["opml", "xml"]
        return fileextensions.contains(url.pathExtension.lowercased())
    }
    
    public func getDownloadedImages() -> [String] {
        let path = self.getImagesFolderPath()
        return self.getAllFiles(path)
    }
    
    
    public func getBaseDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentsDirectory = paths[0] as String
        
        return documentsDirectory
    }
    public func getUrlSessionDownloadFolderPath() -> String {
        let documentsDirectory = self.getBaseDirectory()
        
        let path = documentsDirectory.appending("/urlSessionDownloadFolder")
        
        do {
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        } catch _ as NSError {
            
        }
        return path
    }
    public func getUrlSessionResumeDataFolderPath() -> String {
        let documentsDirectory = self.getBaseDirectory()
        
        let path = documentsDirectory.appending("/urlSessionResumeDataFolder")
        
        do {
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        } catch _ as NSError {
            
        }
        return path
    }
    #if os(tvOS)
    public func getDatabaseFolderPath() -> String {
        let documentsDirectory = FileHelper.getBaseDirectory()
        
        return documentsDirectory
    }
    #endif
    
    public func getImagesFolderPath() -> String {
        var documentsDirectory = self.getBaseDirectory()
        
        #if os(iOS)
        if let containerPath = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: self.securityApplicationGroupIdentifier) {
            
            documentsDirectory = containerPath.path
        }
        #endif
        
        let path = documentsDirectory.appending("/images")
        
        do {
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        } catch _ as NSError {
            
        }
        return path
    }
    
    public func getStatisticExportFolderPath() -> String {
        let documentsDirectory = self.getBaseDirectory()
        
        let path = documentsDirectory.appending("/statistic_export")
        
        do {
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        } catch {
            log("🛑 Error: \(error)")
        }
        return path
    }
    public func getStatisticExportArchiveFolderPath() -> String {
        let documentsDirectory = self.getBaseDirectory()
        
        let path = documentsDirectory.appending("/statistic_export_archive")
        
        do {
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        } catch {
            log("🛑 Error: \(error)")
        }
        return path
    }
    public func getFileSizeFromFile(_ path: String) -> Int64 {
        var usedDiscspace: Int64 = 0
        do {
            let attr = try FileManager.default.attributesOfItem(atPath: path)
            if let fileSize = attr[FileAttributeKey.size] as? Double {
                
                usedDiscspace += Int64(fileSize)
            } else if let fileSize = attr[FileAttributeKey.size] as? Int {
                
                usedDiscspace += Int64(fileSize)
            } else if let fileSize = attr[FileAttributeKey.size] as? Float {
                
                usedDiscspace += Int64(fileSize)
            } else if let fileSize = attr[FileAttributeKey.size] as? Int64 {
                
                usedDiscspace += fileSize
            }
        } catch {
            log("🛑 Error: \(error)")
            
        }
        return usedDiscspace
    }
}


