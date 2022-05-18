//
//  TabbarItem.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/18/22.
//

import SwiftUI

enum TabbarItem: String, CaseIterable, Identifiable {
    case home
    case statistics
    case location
    case profile
    
    var id: String { rawValue }
    
    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .statistics: return "car.2"
        case .location: return "location"
        case .profile: return "person"
        }
    }
    
    var isSystemImage: Bool {
        switch self {
        case .location: return false
        default: return true
        }
    }
    
    var size: CGSize {
        switch self {
        case .home: return CGSize(width: 19, height: 19)
        case .statistics: return CGSize(width: 24, height: 24)
        case .location: return CGSize(width: 19, height: 19)
        case .profile: return CGSize(width: 19, height: 19)
        }
    }
}
