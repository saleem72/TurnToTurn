//
//  Int+Extension.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/12/22.
//

import Foundation

public extension Int {
  var asWord: String? {
    let numberValue = NSNumber(value: self)
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut
    return formatter.string(from: numberValue)
  }
}
