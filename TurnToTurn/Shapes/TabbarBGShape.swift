//
//  TabbarBGShape.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/18/22.
//

import SwiftUI

struct TabbarBGShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.00067*width, y: 0.5*height))
        path.addCurve(to: CGPoint(x: 0.01348*width, y: 0.10977*height), control1: CGPoint(x: 0.00067*width, y: 0.28871*height), control2: CGPoint(x: 0.00067*width, y: 0.18307*height))
        path.addCurve(to: CGPoint(x: 0.02622*width, y: 0.05503*height), control1: CGPoint(x: 0.0171*width, y: 0.08903*height), control2: CGPoint(x: 0.02139*width, y: 0.0706*height))
        path.addCurve(to: CGPoint(x: 0.11704*width, y: 0), control1: CGPoint(x: 0.04328*width, y: 0), control2: CGPoint(x: 0.06786*width, y: 0))
        path.addLine(to: CGPoint(x: 0.34378*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.40056*width, y: 0.02177*height), control1: CGPoint(x: 0.3728*width, y: 0), control2: CGPoint(x: 0.38731*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.44621*width, y: 0.1684*height), control1: CGPoint(x: 0.4138*width, y: 0.04354*height), control2: CGPoint(x: 0.4246*width, y: 0.08516*height))
        path.addLine(to: CGPoint(x: 0.46597*width, y: 0.24452*height))
        path.addCurve(to: CGPoint(x: 0.49948*width, y: 0.33694*height), control1: CGPoint(x: 0.48189*width, y: 0.30584*height), control2: CGPoint(x: 0.48985*width, y: 0.3365*height))
        path.addCurve(to: CGPoint(x: 0.53344*width, y: 0.24762*height), control1: CGPoint(x: 0.50911*width, y: 0.33738*height), control2: CGPoint(x: 0.51722*width, y: 0.30746*height))
        path.addLine(to: CGPoint(x: 0.55743*width, y: 0.1591*height))
        path.addCurve(to: CGPoint(x: 0.60233*width, y: 0.02053*height), control1: CGPoint(x: 0.57876*width, y: 0.0804*height), control2: CGPoint(x: 0.58943*width, y: 0.04105*height))
        path.addCurve(to: CGPoint(x: 0.6574*width, y: 0), control1: CGPoint(x: 0.61523*width, y: 0), control2: CGPoint(x: 0.62928*width, y: 0))
        path.addLine(to: CGPoint(x: 0.88174*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.97256*width, y: 0.05503*height), control1: CGPoint(x: 0.93092*width, y: 0), control2: CGPoint(x: 0.9555*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.9853*width, y: 0.10977*height), control1: CGPoint(x: 0.97739*width, y: 0.0706*height), control2: CGPoint(x: 0.98168*width, y: 0.08903*height))
        path.addCurve(to: CGPoint(x: 0.99811*width, y: 0.5*height), control1: CGPoint(x: 0.99811*width, y: 0.18307*height), control2: CGPoint(x: 0.99811*width, y: 0.28871*height))
        path.addCurve(to: CGPoint(x: 0.9853*width, y: 0.89023*height), control1: CGPoint(x: 0.99811*width, y: 0.71129*height), control2: CGPoint(x: 0.99811*width, y: 0.81693*height))
        path.addCurve(to: CGPoint(x: 0.97256*width, y: 0.94497*height), control1: CGPoint(x: 0.98168*width, y: 0.91097*height), control2: CGPoint(x: 0.97739*width, y: 0.9294*height))
        path.addCurve(to: CGPoint(x: 0.88174*width, y: 1.0*height), control1: CGPoint(x: 0.9555*width, y: 1.0*height), control2: CGPoint(x: 0.93092*width, y: 1.0*height))
        path.addLine(to: CGPoint(x: 0.52744*width, y: 1.0*height))
        path.addLine(to: CGPoint(x: 0.49939*width, y: 1.0*height))
        path.addLine(to: CGPoint(x: 0.47134*width, y: 1.0*height))
        path.addLine(to: CGPoint(x: 0.11704*width, y: 1.0*height))
        path.addCurve(to: CGPoint(x: 0.02622*width, y: 0.94497*height), control1: CGPoint(x: 0.06786*width, y: 1.0*height), control2: CGPoint(x: 0.04328*width, y: 1.0*height))
        path.addCurve(to: CGPoint(x: 0.01348*width, y: 0.89023*height), control1: CGPoint(x: 0.02139*width, y: 0.9294*height), control2: CGPoint(x: 0.0171*width, y: 0.91097*height))
        path.addCurve(to: CGPoint(x: 0.00067*width, y: 0.5*height), control1: CGPoint(x: 0.00067*width, y: 0.81693*height), control2: CGPoint(x: 0.00067*width, y: 0.71129*height))
        path.closeSubpath()
        return path
    }
}
