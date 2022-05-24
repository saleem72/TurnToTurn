//
//  SplitedHStack.swift
//  TurnToTurn
//
//  Created by Yousef on 5/24/22.
//

import SwiftUI

struct SplitedHStack<Left: View, Right: View>: View {
    var left: Left
    var right: Right
    
    private var leftWidth: CGFloat = 120
    private var alignment: VerticalAlignment
    
    init(alignment: VerticalAlignment = .center, @ViewBuilder left: @escaping () -> Left, @ViewBuilder right: @escaping () -> Right) {
        self.left = left()
        self.right = right()
        self.alignment = alignment
    }
    
    var body: some View {
        HStack(alignment: alignment) {
            left
                .frame(width: leftWidth, alignment: .leading)
            right
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    func setWidth(to width: CGFloat) -> SplitedHStack {
        var view = self
        view.leftWidth = width
        return view
    }
}
