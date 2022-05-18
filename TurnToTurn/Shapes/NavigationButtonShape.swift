//
//  NavigationButtonShape.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/11/22.
//

import SwiftUI

struct NavigationButtonShape: Shape {
    
    let direction: NavigationButtonDirection
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        if direction == .leading {
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addQuadCurve(
                to: CGPoint(x: rect.minX, y: rect.maxY),
                control: CGPoint(x: rect.maxX * 1.5, y: rect.midY)
            )
        } else {
            path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.maxY),
                control: CGPoint(x: -rect.width * 0.5, y: rect.midY)
            )
        }
        
        return path
    }
}
