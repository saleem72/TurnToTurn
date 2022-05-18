//
//  LinearGradient+Extension.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/9/22.
//

import SwiftUI

extension LinearGradient {
    init(colors: Color..., startPoint: UnitPoint = .top, endPoint: UnitPoint = .bottomTrailing) {
        self.init(gradient: Gradient(colors: colors), startPoint: .top, endPoint: .bottom)
    }
    
    static let lineStroke: LinearGradient = LinearGradient(colors: Color("red"), Color.white.opacity(0), startPoint: .top, endPoint: .bottom)
    
    static let button: LinearGradient = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: Color("buttonFrom"), location: 0),
            .init(color: Color("buttonTo"), location: 1)
        ]),
        startPoint: UnitPoint(x: 0.4954128289693158, y: -7.316265009519703e-10),
        endPoint: UnitPoint(x: 0.49541283539674086, y: 1.3684210776570847)
    )
    
    static let tabBar: LinearGradient = LinearGradient(colors: Color("tabbarFrom"), Color("tabbarTo"), startPoint: .top, endPoint: .bottom)
    
    static let location: LinearGradient = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: Color("locationFrom"), location: 0),
            .init(color: Color("locationTo"), location: 1)
        ]),
        startPoint: UnitPoint(x: 0.24444444902100343, y: 0.2555555673491328),
        endPoint: UnitPoint(x: 0.5888889085955011, y: 0.8333333392189085)
    )
    
    static let blueChart: LinearGradient = LinearGradient(colors: Color("locationFrom"), Color("locationTo"))
    
    static let navigationButton = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: Color("navigationButtonFrom"), location: 0),
            .init(color: Color("navigationButtonTo"), location: 1)
        ]),
        startPoint: UnitPoint(x: 0.5034852009095945, y: 0.2291403044258882),
        endPoint: UnitPoint(x: 0.5015591697898806, y: 1.0450044188247574)
    )
    
    static let screen = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: Color("screenFrom"), location: 0.030805686488747597),
            .init(color: Color("screenTo"), location: 1)
        ]),
        startPoint: UnitPoint(x: 0.5, y: -3.0616171314629196e-17),
        endPoint: UnitPoint(x: 0.5, y: 0.9999999999999999)
    )
    
    static let tabbar = LinearGradient(
        gradient: Gradient(stops: [
            Gradient.Stop.init(color: Color.fromHexString("B13025"), location: 0),
            Gradient.Stop.init(color: Color.fromHexString("28100D"), location: 1)
        ]),
        startPoint: .top,
        endPoint: .bottom
    )
    
}
