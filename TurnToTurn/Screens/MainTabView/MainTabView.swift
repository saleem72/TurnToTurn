//
//  MainTabView.swift
//  TurnToTurn
//
//  Created by Yousef on 5/18/22.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: TabbarItem = .home
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeScreen()
                    .tag(TabbarItem.home)
                
                StatictisScreen()
                    .tag(TabbarItem.statistics)
                
                LocationsScreen()
                    .tag(TabbarItem.location)
                
                ProfileScreen()
                    .tag(TabbarItem.profile)
            }
            AppTabbarView(selectedTab: $selectedTab) { }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .preferredColorScheme(.dark)
    }
}
