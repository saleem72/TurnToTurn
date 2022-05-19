//
//  UserImageView.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/9/22.
//

import SwiftUI

struct UserImageView: View {
    var body: some View {
        Image("user")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 36, height: 36)
            .clipShape(Circle())
            .padding(4)
            .background(
                Circle()
                    .fill(Color.white)
            )
    }
}
