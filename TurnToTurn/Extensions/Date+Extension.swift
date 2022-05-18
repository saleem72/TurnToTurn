//
//  Date+Extension.swift
//  PlaygroundForTesting
//
//  Created by Yousef on 7/20/21.
//

import Foundation

fileprivate class DateManager {
    static var shared = DateManager()
    
    private var formatter = DateFormatter()
    
    private init() { }
   
    func month(from date: Date) -> String {
        formatter.dateFormat = "LLLL"
        return formatter.string(from: date)
    }
    
    func day(from date: Date) -> String {
        formatter.dateFormat = "eee"
        return formatter.string(from: date)
    }
    
    func longDate(_ date: Date) -> String {
        formatter.dateStyle = .long
        
        return formatter.string(from: date)
    }
    
    func mediumDate(_ date: Date) -> String {
        formatter.dateStyle = .medium
        
        return formatter.string(from: date)
    }
    
    func shortDate(_ date: Date) -> String {
        formatter.dateFormat = "dd/MMM"
        
        return formatter.string(from: date)
    }
    
    func custom(_ date: Date) -> String {
        formatter.dateFormat = "dd/ MMM /yyyy"
        return formatter.string(from: date)
    }
    
    func from(_ str: String) -> Date {
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.date(from: str) ?? Date()
    }
    
    func shortTime(_ date: Date) -> String {
        formatter.dateFormat = "hh:mm"
        return formatter.string(from: date)
    }
    
    func mediumTime(_ date: Date) -> String {
        formatter.dateFormat = "hh:mm:ss"
        return formatter.string(from: date)
    }
    
    func dateFormatter() -> DateFormatter {
        return formatter
    }
    
    func dateTime(_ date: Date) -> String {
        formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        return formatter.string(from: date)
    }
    
    func fromDateTime(_ str: String) -> Date {
        formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        
        return formatter.date(from: str) ?? Date.init(timeIntervalSince1970: 0)
    }
}

extension Date {
    func equal(date: Date) -> Bool {
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
        let selfComponents = Calendar.current.dateComponents([.year, .month, .day], from: self)
        return dateComponents == selfComponents
    }
    
    func setTime(hour: Int, minutes: Int, seconds: Int) -> Date {
        return Calendar.iso8601.date(bySettingHour: hour, minute: minutes, second: seconds, of: self)!
    }
    
    static func dateComponents(timeZone: TimeZone? = TimeZone(secondsFromGMT: 0), day: Int, month: Int, year: Int, hour: Int = 12, minutes: Int = 0, seconds: Int = 0) -> Date {
        let calendar = Calendar.current
        let components = DateComponents(timeZone: timeZone, year: year, month: month, day: day, hour: hour, minute: minutes, second: seconds)
        return calendar.date(from: components)!
    }
    
    var weekdayIndex: Int {
        let weekday = Calendar.current.component(.weekday, from: self)
        return weekday
    }
    
    var weekday: String {
        return DateManager.shared.day(from: self)
    }
    
    var day: Int {
        let day = Calendar.current.component(.day, from: self)
        return day
    }
    
    var month: String {
        return DateManager.shared.month(from: self)
    }
    
    var year: Int {
        let day = Calendar.current.component(.year, from: self)
        return day
    }
    
    var monthDays: Int {
        let range = Calendar.current.range(of: .day, in: .month, for: self)!
        return range.count
    }
    
    static var monthsList: [String] {
        var result = [String]()
        for i in 1...12 {
            let date = dateComponents(day: 1, month: i, year: 2000)
            result.append(DateManager.shared.month(from: date))
        }
        return result
    }
    
    var week: [Date] {
        
        /*
        let calendar = Calendar.current
        let temp = Weekday.sunday.rawValue
        let components = DateComponents(weekday: temp)

           
        
        let newTemp = calendar.nextDate(
            after: self,
            matching: components,
            matchingPolicy: .nextTime,
            direction: .backward
        )!
        
        print(newTemp.longDate)
        
        let daysRange = calendar.range(of: .weekday, in: .weekOfMonth, for: newTemp)!
        dump(daysRange)
            return daysRange
            .compactMap { calendar.date(byAdding: .day, value: $0 - 1, to: newTemp) }
        */
        
        let calendar = Calendar.current
        let week = calendar.dateInterval(of: .weekOfMonth, for: Date())
        
        guard let firstDay = week?.start  else { return [] }
        var result = [Date]()
        (0..<7).forEach { day in
            if let weekDay = calendar.date(byAdding: .day, value: day, to: firstDay) {
                result.append(weekDay)
            }
        }
        return result
    }
    
    var longDate: String {
        DateManager.shared.longDate(self)
    }
    
    var mediumDate: String {
        DateManager.shared.mediumDate(self)
    }
    
    var shortDate: String {
        DateManager.shared.shortDate(self)
    }
    
    var custom: String {
        DateManager.shared.custom(self)
    }
    
    func date(byAdding object : Calendar.Component, value: Int) -> Date {
        Calendar.iso8601.date(byAdding: object, value: value, to: self) ?? Date()
    }
    
    static func from(_ str: String) -> Date {
        DateManager.shared.from(str)
    }
    
    var shortTime: String {
        DateManager.shared.shortTime(self)
    }
    
    var mediumTime: String {
        DateManager.shared.mediumTime(self)
    }
    
    static func dateFormatter() -> DateFormatter {
        DateManager.shared.dateFormatter()
    }
    
    static func fromDateTime(_ str: String) -> Date {
        DateManager.shared.fromDateTime(str)
    }
    
    var dateTime: String {
        DateManager.shared.dateTime(self)
    }
    
//    var elapsedPeriod: String {
//        
//        let interval = Calendar.current.dateComponents([.year, .month, .day], from: self, to: Date())
//        
//        let year = interval.year ?? 0
//        let month = interval.month ?? 0
//        let day = interval.day ?? 0
//        
//        if year > 0 {
//            return year == 1
//                ? "\(year)" + " " + "year ago".localized
//                : "\(year)" + " " + "years ago".localized
//        } else if month > 0 {
//            return month == 1
//                ? "\(month)" + " " + "month ago".localized
//                : "\(month)" + " " + "months ago".localized
//        } else if day > 0 {
//            if (22...31).contains(day) {
//                return "4 " +  "weeks ago".localized
//            } else if (15...21).contains(day) {
//                return "3 " + "weeks ago".localized
//            } else if (8...14).contains(day) {
//                return "2 " + "weeks ago".localized
//            } else if (2...7).contains(day) {
//                return "last week".localized
//            } else {
//                return day == 1
//                    ? "yesterday".localized
//                    : "\(day)" + " " + "days ago".localized
//            }
//        } else {
//            // if you want to present hours
//            // let interval = Calendar.current.dateComponents([.hour, .minute, .second], from: self, to: Date())
//            return "a moment ago".localized
//        }
//    }
    
}

extension Calendar {
    static let iso8601 = Calendar(identifier: .iso8601)
}
