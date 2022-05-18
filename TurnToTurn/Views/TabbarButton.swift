//
//  TabbarButton.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/18/22.
//

import SwiftUI

struct TabbarButton: View {
    
    var tab: TabbarItem
    @Binding var selectedTab: TabbarItem
    var animation: Namespace.ID
    
    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                selectedTab = tab
            }
        }, label: {
            label
        })
    }
    
    private var label: some View {
        
        ZStack {
            
            if tab == selectedTab {
                Circle()
                    .stroke(Color.fromHexString("B13025"))
                    .animation(.none)
                Circle()
                    .fill(Color.red)
                    .frame(width: 4, height: 4)
                    .offset(y: 30)
                    .matchedGeometryEffect(id: "TabCirle", in: animation)
            }
            
            LinearGradient(
                gradient: Gradient(stops: [
                    Gradient.Stop.init(color: Color.fromHexString("B13025"), location: 0),
                    Gradient.Stop.init(color: Color.fromHexString("28100D"), location: 1)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(width: 44, height: 44)
            .mask(icon)
        }
        .frame(width: 44, height: 44)
    }
    
    private var icon: some View {
        let image = tab.isSystemImage ? Image(systemName: tab.icon) : Image(tab.icon).renderingMode(.template)
        return image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: tab.size.width, height: tab.size.height)
            .frame(width: 44, height: 44)
    }
    
}

