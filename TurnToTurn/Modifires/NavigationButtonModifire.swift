//
//  NavigationButtonModifire.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/11/22.
//

import SwiftUI

struct NavigationButtonModifire: ViewModifier {
    let direction: NavigationButtonDirection
    func body(content: Content) -> some View {
        ZStack(alignment: direction == .leading ? .leading : .trailing) {
            content
                .font(.headline)
                .foregroundColor(Color.palette.secondary)
                .padding(.leading, direction == .leading ? 20 : 0)
                .padding(.trailing, direction == .trailing ? 20 : 0)
        }  // width: 146, height: 118
        .frame(width: 118, height: 146, alignment: direction == .leading ? .leading : .trailing)
        .background(
            NavigationButtonShape(direction: direction)
                .fill(LinearGradient.navigationButton)
                .mask(
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: Color.clear, location: 0),
                            .init(color: Color.black, location: 1)
                        ]),
                        startPoint: direction == .leading ? .leading : .trailing,
                        endPoint: direction == .leading ? .trailing : .leading
                    )
                )
        )
    }
}

extension View {
    func navigationButton(direction: NavigationButtonDirection = .leading) -> some View {
        modifier(NavigationButtonModifire(direction: direction))
    }
}
