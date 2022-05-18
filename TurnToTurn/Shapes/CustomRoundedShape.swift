//
//  CustomRoundedShape.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/11/22.
//

import SwiftUI

struct CustomRoundedShape: Shape {
    
    var corners: UIRectCorner = [.topLeft, .topRight, .bottomRight]
    var radius: Double = 15
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
