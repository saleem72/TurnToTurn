//
//  LoadingView.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/12/22.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.palette.red.opacity(0.1)
                .edgesIgnoringSafeArea(.all)
            VStack {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.palette.red))
                    .scaleEffect(3)
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
