//
//  Ellipes.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/18/22.
//

import SwiftUI

struct Ellipes: Shape {
    func path(in rect: CGRect) -> Path {
        let ellipes = UIBezierPath(ovalIn: rect)
        return Path(ellipes.cgPath)
    }
}
