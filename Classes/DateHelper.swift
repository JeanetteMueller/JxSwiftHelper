//
//  DateHelper.swift
//  JxSwiftHelper
//
//  Created by Jeanette Müller on 08.02.21.
//

import Foundation

public class DateHelper {
    public class func currentWeekDay() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.autoupdatingCurrent
        formatter.dateFormat = "EEE"
        
        return formatter.string(for: Date()) ?? ""
    }
    public class func getWeekDays() -> [String] {
        
        let formatter = DateFormatter()
        formatter.locale = Locale.autoupdatingCurrent
        formatter.dateFormat = "EEE"
        
        return [
            formatter.string(for: Date(timeIntervalSince1970: (60*60*24)*4))!,
            formatter.string(for: Date(timeIntervalSince1970: (60*60*24)*5))!,
            formatter.string(for: Date(timeIntervalSince1970: (60*60*24)*6))!,
            formatter.string(for: Date(timeIntervalSince1970: (60*60*24)*7))!,
            formatter.string(for: Date(timeIntervalSince1970: (60*60*24)*8))!,
            formatter.string(for: Date(timeIntervalSince1970: (60*60*24)*9))!,
            formatter.string(for: Date(timeIntervalSince1970: (60*60*24)*10))!
        ]
    }
}
