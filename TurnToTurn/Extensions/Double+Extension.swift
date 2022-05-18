//
//  Double+Extension.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/12/22.
//

import Foundation

extension Double {
    
    struct Distance {
        let value: String
        let unit: String
    }
    
    func removeExtraZeros() -> String {
        var string = String(self)
        string = string.replacingOccurrences(of: "^([\\d,]+)$|^([\\d,]+)\\.0*$|^([\\d,]+\\.[0-9]*?)0*$", with: "$1$2$3", options: .regularExpression)
        
        return string
    }
    
    var toDistance: String {
        let meters = Int(self)
        if meters > 1000 {
            let kmDistance = meters / 1000
            return "\(kmDistance) km"
        } else {
            return "\(meters) m"
        }
    }
    
    var asWord: String? {
      let numberValue = NSNumber(value: Int(self))
      let formatter = NumberFormatter()
      formatter.numberStyle = .spellOut
      return formatter.string(from: numberValue)
    }
    
    var toDigits: Double {
        let temp = Int(self * 100)
        return Double(temp) / 100
    }
    
    var towLinesDistance: Distance {
        let meters = Int(self)
        if meters > 1000 {
            let kmDistance = Double(meters) / 1000
            return Distance(value: kmDistance.toDigits.removeExtraZeros(), unit: "km")
        } else {
            return Distance(value: "\(meters)", unit: "m")
        }
    }
    
    var toTimePeriod: String {
        let interval = Int(self)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        
        var result: String = ""
        if hours > 0 {
            result = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            if minutes > 0 {
                result = String(format: "%02d:%02d", minutes, seconds)
            } else {
                result = String(format: "%02d", seconds)
            }
        }
        return result
    }
    
    var toMinutes: String {
        let interval = Int(self)
        let seconds = interval % 60
        var minutes = (interval / 60) % 60
        if seconds > 0 {
            minutes += 1
        }
        
        return "\(minutes)"
    }
    
}
