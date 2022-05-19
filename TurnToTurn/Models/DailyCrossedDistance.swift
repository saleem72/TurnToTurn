//
//  DailyCrossedDistance.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/17/22.
//

import SwiftUI

struct DailyCrossedDistance: Identifiable {
    let date: Date
    let distance: Double
    
    var id: Date { date }
}

extension DailyCrossedDistance: GraphColumnsChartItem {
    var label: String { date.weekday}
    var value: CGFloat { CGFloat(distance) }
}

extension DailyCrossedDistance {
    static var mockData: [DailyCrossedDistance] = {
        var array = [DailyCrossedDistance]()
        let weekDays = Date().week
        for day in weekDays {
            array.append(.init(date: day, distance: Double.random(in: 20..<100) * 1000))
        }
        return array
    }()
}
