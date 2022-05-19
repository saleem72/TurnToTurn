//
//  CGFloat+Extension.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/17/22.
//

import UIKit

extension CGFloat {
    var nextComplete: CGFloat {
        var intValue = Int(self)
        var fifties: Double
        var hunderds: Double
        
        switch intValue {
        case 0...1000:
            fifties = 50
            hunderds = 100
        case 1000...10_000:
            fifties = 5000
            hunderds = 10000
        default:
            fifties = 50000
            hunderds = 100000
        }
        
        while true {
            if Double(intValue).truncatingRemainder(dividingBy: fifties) == 0 || Double(intValue).truncatingRemainder(dividingBy: hunderds) == 0 {
                return CGFloat(intValue)
            } else {
                intValue += 1
            }
        }
    }
    
    
    func removeExtraZeros() -> String {
        var string = String(Double(self))
        string = string.replacingOccurrences(of: "^([\\d,]+)$|^([\\d,]+)\\.0*$|^([\\d,]+\\.[0-9]*?)0*$", with: "$1$2$3", options: .regularExpression)
        
        return string
    }
}
