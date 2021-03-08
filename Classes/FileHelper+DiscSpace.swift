//
//  FileHelper+DiscSpace.swift
//  JxSwiftHelper
//
//  Created by Jeanette Müller on 08.01.21.
//

import Foundation

extension FileHelper {
    
    //MARK: Formatter MB only
    public class func MBFormatter(_ bytes: Int64) -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = ByteCountFormatter.Units.useMB
        formatter.countStyle = ByteCountFormatter.CountStyle.decimal
        formatter.includesUnit = false
        return formatter.string(fromByteCount: bytes) as String
    }
    
    public class func readableFileSize(_ size: Int64) -> String {
        return ByteCountFormatter.string(fromByteCount: size, countStyle: ByteCountFormatter.CountStyle.file)
    }
    
    //MARK: Get String Value
    public class var totalDiskSpace:String {
        get {
            return ByteCountFormatter.string(fromByteCount: totalDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.file)
        }
    }
    
    public class var freeDiskSpace:String {
        get {
            return ByteCountFormatter.string(fromByteCount: freeDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.file)
        }
    }
    
    public class var usedDiskSpace:String {
        get {
            return ByteCountFormatter.string(fromByteCount: usedDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.file)
        }
    }
    
    
    //MARK: Get raw value
    public class var totalDiskSpaceInBytes:Int64 {
        get {
            var space: Int64 = 0
            
            do {
                if let s = try URL(fileURLWithPath: NSHomeDirectory() as String).resourceValues(forKeys: [URLResourceKey.volumeTotalCapacityKey]).volumeTotalCapacity {
                    space = Int64(s)
                }
                
                return space
            } catch {
                space = 0
            }
            
            
            do {
                let systemAttributes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String)
                if let space = (systemAttributes[FileAttributeKey.systemSize] as? NSNumber)?.int64Value {
                    return space
                }
            } catch {
                return 0
            }
            
            return space
        }
    }
    
    public class var freeDiskSpaceInBytes:Int64 {
        get {
            var space: Int64 = 0
            
            do {
                if let s = try URL(fileURLWithPath: NSHomeDirectory() as String).resourceValues(forKeys: [URLResourceKey.volumeAvailableCapacityForImportantUsageKey]).volumeAvailableCapacityForImportantUsage {
                    
                    space = Int64(s)
                }
                
                return space
            } catch {
                space = 0
            }
            
            
            
            do {
                let systemAttributes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String)
                if let space = (systemAttributes[FileAttributeKey.systemFreeSize] as? NSNumber)?.int64Value{
                    return space
                }
            } catch {
                return 0
            }
            
            return space
        }
    }
    
    public class var usedDiskSpaceInBytes:Int64 {
        get {
            let usedSpace = totalDiskSpaceInBytes - freeDiskSpaceInBytes
            return usedSpace
        }
    }
}
