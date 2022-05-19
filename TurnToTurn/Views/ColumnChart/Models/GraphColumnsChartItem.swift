//
//  GraphColumnsChartItem.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/18/22.
//

import SwiftUI

protocol GraphColumnsChartItem: Identifiable {
    var label: String { get }
    var value: CGFloat { get }
}
