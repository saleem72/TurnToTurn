//
//  ErrorView.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/10/22.
//

import SwiftUI

struct ErrorView: View {
    @Binding var error: MapManagerError?
    var body: some View {
        ZStack {
            BlurView()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack(spacing: 32) {
                    Image(systemName: "xmark.octagon.fill")
                        .font(.system(size: 140, weight: .bold))
                        .foregroundColor(Color("red"))
                    
                    Text(error?.localizedDescription ?? "")
                        .font(.headline)
                    
                    Button(action: {
                        error = nil
                    }, label: {
                        HStack {
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .font(Font.gallery.headline())
                                .foregroundColor(Color.white)
                            
                            Text("Retry")
                                .font(Font.gallery.bold(17))
                                .foregroundColor(Color.white)
                        }
                        .gradientWithIconButton(height: 44)
                    })
                    .frame(width: 200)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.secondary.opacity(0.4))
                        .shadow(color: Color.primary.opacity(0.2), radius: 20, x: 0, y: 10)
                )
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: .constant(MapManagerError.locationServicesDisabled))
    }
}
