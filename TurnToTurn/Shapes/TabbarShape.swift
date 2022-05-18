//
//  TabbarShape.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/18/22.
//

import SwiftUI

struct TabbarShape : Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.00067*width, y: 0.28261*height))
        path.addCurve(to: CGPoint(x: 0.06461*width, y: 0.01087*height), control1: CGPoint(x: 0.00067*width, y: 0.13253*height), control2: CGPoint(x: 0.0293*width, y: 0.01087*height))
        path.addLine(to: CGPoint(x: 0.36654*width, y: 0.01087*height))
        path.addCurve(to: CGPoint(x: 0.4255*width, y: 0.1283*height), control1: CGPoint(x: 0.38932*width, y: 0.01087*height), control2: CGPoint(x: 0.41093*width, y: 0.0539*height))
        path.addLine(to: CGPoint(x: 0.48016*width, y: 0.40726*height))
        path.addCurve(to: CGPoint(x: 0.51911*width, y: 0.40903*height), control1: CGPoint(x: 0.49024*width, y: 0.45873*height), control2: CGPoint(x: 0.50877*width, y: 0.45957*height))
        path.addLine(to: CGPoint(x: 0.57762*width, y: 0.12301*height))
        path.addCurve(to: CGPoint(x: 0.63552*width, y: 0.01087*height), control1: CGPoint(x: 0.59219*width, y: 0.05177*height), control2: CGPoint(x: 0.61331*width, y: 0.01087*height))
        path.addLine(to: CGPoint(x: 0.93417*width, y: 0.01087*height))
        path.addCurve(to: CGPoint(x: 0.99811*width, y: 0.28261*height), control1: CGPoint(x: 0.96949*width, y: 0.01087*height), control2: CGPoint(x: 0.99811*width, y: 0.13253*height))
        path.addLine(to: CGPoint(x: 0.99811*width, y: 0.72826*height))
        path.addCurve(to: CGPoint(x: 0.93417*width, y: 1.0*height), control1: CGPoint(x: 0.99811*width, y: 0.87834*height), control2: CGPoint(x: 0.96949*width, y: 1.0*height))
        path.addLine(to: CGPoint(x: 0.54741*width, y: 1.0*height))
        path.addCurve(to: CGPoint(x: 0.52165*width, y: 0.96407*height), control1: CGPoint(x: 0.53814*width, y: 1.0*height), control2: CGPoint(x: 0.52912*width, y: 0.98741*height))
        path.addLine(to: CGPoint(x: 0.51151*width, y: 0.93238*height))
        path.addCurve(to: CGPoint(x: 0.48727*width, y: 0.93238*height), control1: CGPoint(x: 0.5043*width, y: 0.90984*height), control2: CGPoint(x: 0.49448*width, y: 0.90984*height))
        path.addLine(to: CGPoint(x: 0.47713*width, y: 0.96407*height))
        path.addCurve(to: CGPoint(x: 0.45137*width, y: 1.0*height), control1: CGPoint(x: 0.46966*width, y: 0.98741*height), control2: CGPoint(x: 0.46064*width, y: 1.0*height))
        path.addLine(to: CGPoint(x: 0.06461*width, y: 1.0*height))
        path.addCurve(to: CGPoint(x: 0.00067*width, y: 0.72826*height), control1: CGPoint(x: 0.02929*width, y: 1.0*height), control2: CGPoint(x: 0.00067*width, y: 0.87834*height))
        path.addLine(to: CGPoint(x: 0.00067*width, y: 0.28261*height))
        path.closeSubpath()
        return path
    }
}
