//
//  BottomSheetNotificationView.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/17/22.
//

import SwiftUI

struct BottomSheetNotificationView<Content: View>: View {
    let content: Content
    @Binding var isVisible: Bool
    init(isVisible: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        self._isVisible = isVisible
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            background
            notificationContent
        }
    }
}

struct BottomSheetNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetNotificationView(isVisible: .constant(true)) {
            Text("Hello world!")
        }
        .preferredColorScheme(.dark)
    }
}

extension BottomSheetNotificationView {
    private var notificationContent: some View {
        VStack(spacing: 16) {
            dragHandle
            content
        }
        .frame(maxWidth: .infinity)
        .font(.headline)
        .padding()
        .background(notificationBackground)
        .transition(.move(edge: .bottom))
    }
    private var dragHandle: some View {
        Rectangle()
            .fill(Color.white)
            .frame(width: 36, height: 5)
    }
    
    private var notificationBackground: some View {
        ZStack {
            CustomRoundedShape(corners: [.topLeft, .topRight], radius: 40)
                .fill(Color.white.opacity(0.08))
                .blur(radius: 20)
            
            
                CustomRoundedShape(corners: [.topLeft, .topRight], radius: 40)
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: Color.white.opacity(0.6), location: 0),
                                .init(color: Color.white.opacity(0.0), location: 1),
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private var background: some View {
        Color("screenFrom").opacity(0.001)
            .onTapGesture {
                withAnimation(.easeIn) {
                    isVisible = false
                }
            }
    }
    
}
