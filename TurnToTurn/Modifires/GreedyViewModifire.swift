//
//  GreedyViewModifire.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/17/22.
//

import SwiftUI

struct GreedyViewModifire: ViewModifier {
    
    let alignment: Alignment
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }
}

extension View {
    func greedyView(alignment: Alignment = .center) -> some View {
        modifier(GreedyViewModifire(alignment: alignment))
    }
}
