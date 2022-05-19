//
//  StatictisScreen.swift
//  TurnToTurn
//
//  Created by Yousef on 5/18/22.
//

import SwiftUI

struct StatictisScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var date: Date = .init()
    @State private var week: [DailyCrossedDistance] = []
    @State private var showActivitiesMessage: Bool = true
    
    var body: some View {
        
        ZStack {
            
//            LinearGradient.screen
//                .edgesIgnoringSafeArea(.all)
            BackgroundView()
            content
            possibleActivitiesMessage()
        }
        .navigationBarHidden(true)
    }
    
    func generateMockData(date: Date) {
        let daysList = date.week
        var result = [DailyCrossedDistance]()
        for day in daysList {
            result.append(.init(date: day, distance: Double.random(in: 5...100) * 1000))
        }
        week = result
    }
}


extension StatictisScreen {
    
    private var content: some View {
        VStack(spacing: 0) {
            header
            VStack(spacing: 32) {
                DropDownDateView(date: $date)
                    .zIndex(1.0)
                
                mileageChart()
            }
            
            Spacer(minLength: 0)
        }
        .onAppear(perform: {
            generateMockData(date: date)
        })
        .onChange(of: date, perform: generateMockData)
    }
    
    private var header: some View {
        HStack {
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.backward")
                    .frame(width: 44, height: 44)
                    .navigationButton(direction: .leading)
            })
            
            Spacer(minLength: 0)
            
            Button(action: {}, label: {
                Image(systemName: "xmark")
                    .frame(width: 44, height: 44)
                    .navigationButton(direction: .trailing)
            })
        }
        .frame(height: 146)
        .overlay(
            Text("Timeline")
                .font(Font.gallery.semiBold(17))
        )
    }
    
    @ViewBuilder
    private func mileageChart() -> some View {
        if week.count > 0 {
            GraphColumnsChartView(data: week, unit: "Km")
                .frame(width: 231, height: 134)
//                .frame(width: 350, height: 300)
        }
    }
    
}

//MARK: - Activities Message
extension StatictisScreen {
    @ViewBuilder
    private func possibleActivitiesMessage() -> some View {
        if showActivitiesMessage {
            BottomSheetNotificationView(isVisible: $showActivitiesMessage) {
                VStack {
                    activitiesMessageDateInput
                    
                    Rectangle()
                        .fill(Color.white.opacity(0.4))
                        .frame(height: 2)
                    
                    activitiesMessageButtons
                        .padding(.top, 20)
                    
                    Spacer()
                        .frame(height: 120)
                }
            }
        }
    }
    
    private var activitiesMessageButtons: some View {
        HStack {
            VStack {
                Button(action: {}, label: {
                    VStack(spacing: 16) {
                        Image(systemName: "gauge.badge.plus")
                            .font(.headline)
                        
                        Text("Km")
                            .font(Font.gallery.headline())
                    }
                    .foregroundColor(.white)
                })
            }
            .frame(maxWidth: .infinity)
            
            VStack {
                Button(action: {}, label: {
                    VStack(spacing: 16) {
                        Image("chart.line.uptrend.xyaxis")
                            .font(.headline)
                        
                        Text("Following")
                            .font(Font.gallery.headline())
                    }
                    .foregroundColor(.white)
                })
                
                
            }
            .frame(maxWidth: .infinity)
            
            VStack {
                Button(action: {}, label: {
                    VStack(spacing: 16) {
                        Image(systemName: "map.fill")
                            .font(.headline)
                        
                        Text("Map")
                            .font(Font.gallery.headline())
                    }
                    .foregroundColor(.white)
                })
            }
            .frame(maxWidth: .infinity)
            
            VStack {
                Button(action: {}, label: {
                    VStack(spacing: 16) {
                        Image(systemName: "square.and.arrow.up.fill")
                            .font(.headline)
                        
                        Text("Saved")
                            .font(Font.gallery.headline())
                    }
                    .foregroundColor(.white)
                })
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    private var activitiesMessageDateInput: some View {
        HStack {
            Button(action: {}, label: {
                Image(systemName: "chevron.backward")
                    .font(.headline)
                    .foregroundColor(.white)
            })
            .frame(width: 44, height: 44)
            .padding(.leading)
            
            Spacer(minLength: 0)
            
            Button(action: {}, label: {
                Image(systemName: "chevron.forward")
                    .font(.headline)
                    .foregroundColor(.white)
            })
            .frame(width: 44, height: 44)
            .padding(.trailing)
            
        }
        .overlay(activitiesMessageDatePicker)
    }
    
    private var activitiesMessageDatePicker: some View {
        DatePicker("", selection: $date, displayedComponents: [.date])
            .labelsHidden()
            .accentColor(.white)
    }
    
}

struct StatictisScreen_Previews: PreviewProvider {
    static var previews: some View {
        StatictisScreen()
            .preferredColorScheme(.dark)
    }
}
