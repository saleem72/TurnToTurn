//
//  AppTabbarView.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/18/22.
//

import SwiftUI



struct AppTabbarView: View {
    
    @Binding var selectedTab: TabbarItem
    @Namespace private var animation
    private var action: () -> Void
    
    init(selectedTab: Binding<TabbarItem>, action: @escaping () -> Void) {
        self._selectedTab = selectedTab
        self.action = action
    }
    
    var body: some View {
        ZStack {
            HStack {
                buttonsLeftSection
                Spacer(minLength: 0)
                actionButton
                Spacer(minLength: 0)
                buttonsRightSection
            }
        }
        .frame(height: 75)
        .frame(maxWidth: .infinity)
        .background(backgroundLayer)
    }
}

extension AppTabbarView {
    
    private var actionButton: some View {
        Button(action: {
            
        }, label: {
            ZStack {
                Image(systemName: "drop.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.white.opacity(0.11))
                    .rotationEffect(Angle(degrees: 180))
                    .overlay(
                        LinearGradient.tabbar
                            .mask(
                                Image(systemName: "drop.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .rotationEffect(Angle(degrees: 180))
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 9)
                            )
                    )
                    .overlay(
                        Image(systemName: "plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 14, height: 14)
                            .foregroundColor(.white)
                            .offset(y: -5)
                    )
            }
            .compositingGroup()
        })
        .frame(width: 55.24, height: 73)
        .offset(y: -53)
    }
    
    private var buttonsLeftSection: some View {
        HStack(spacing: 32) {
            TabbarButton(tab: TabbarItem.home, selectedTab: $selectedTab, animation: animation)
            TabbarButton(tab: TabbarItem.statistics, selectedTab: $selectedTab, animation: animation)
        }
        .padding(.leading)
    }
    
    private var buttonsRightSection: some View {
        HStack(spacing: 32) {
            TabbarButton(tab: TabbarItem.location, selectedTab: $selectedTab, animation: animation)
            TabbarButton(tab: TabbarItem.profile, selectedTab: $selectedTab, animation: animation)
        }
        .padding(.trailing)
    }
    
    private var backgroundLayer: some View {
        ZStack {
            Ellipes()
                .fill(Color.fromHexString("#FF6363"))
                .frame(width: 42, height: 68)
                .blur(radius: 16)
                .scaleEffect(2)
                .offset(y: 34)
            
            TabbarBGShape()
                .fill(Color.fromHexString("EB0000").opacity(0.31))
                .edgesIgnoringSafeArea(.bottom)
            
            TabbarShape()
                .fill(
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: Color(red: 0.175, green: 0.205, blue: 0.262, opacity: 1), location: 0),
                            .init(color: Color(red: 0.043, green: 0.045, blue: 0.05, opacity: 1), location: 0.75)
                        ]),
                        startPoint: .top, // UnitPoint(x: 0.25, y: 0.5),
                        endPoint: .bottom // UnitPoint(x: 0.75, y: 0.5)
                    )
                )
                .edgesIgnoringSafeArea(.bottom)
                .shadow(color: Color.white.opacity(0.3), radius: 0, x: 0, y: -2)
        }
    }
}

struct AppTabbarView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
            .preferredColorScheme(.dark)
    }
}
