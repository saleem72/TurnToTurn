//
//  BlurView.swift
//  Sodoku
//
//  Created by Yousef on 4/21/22.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    
    var style: UIBlurEffect.Style
    var alpha: CGFloat
    init(style: UIBlurEffect.Style = .systemThinMaterial, alpha: CGFloat = 1) {
        self.style = style
        self.alpha = alpha
    }
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: style)
        let view = UIVisualEffectView(effect: blurEffect)
        view.alpha = alpha
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) { }
}

