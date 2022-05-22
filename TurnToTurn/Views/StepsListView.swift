//
//  StepsListView.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/11/22.
//

import SwiftUI

struct StepsListView: View {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject private var manager: MapManager
    
    var body: some View {
        NavigationView {
            ZStack {
                if manager.directions.count > 0 {
                    LinearGradient.screen.edgesIgnoringSafeArea(.all)
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            ForEach(manager.directions.indices) { idx in
                                VStack {
                                    StepView(step: manager.directions[idx])
                                    if idx != manager.directions.indices.last {
                                        Divider()
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Steps")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: toolbarButton)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

extension StepsListView {
    func toolbarButton() -> some ToolbarContent {
        Group {
            
            ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark.square")
                        .font(.title2)
                        .foregroundColor(.black)
                        .frame(width: 44, height: 44)
                })
            }
        }
    }
}



struct StepView: View {
    let step: MapStep
    
    var body: some View {
        HStack {
            Image(step.stepType.icon)
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .foregroundColor(Color.palette.blue)
                .padding(.leading)
            
            VStack(alignment: .leading) {
                Text(step.stepType.title)
                    .font(.headline)
                    .foregroundColor(Color.palette.primary)
                
                Text(step.instructions)
                    .font(.footnote)
                    .foregroundColor(Color.palette.secondary)
                if let notice = step.notice {
                    Text(notice)
                        .font(.footnote)
                        .foregroundColor(Color.palette.secondary)
                }
            }
            .padding()
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(step.distance.toDistance)
                .padding(.trailing)
        }
    }
}
