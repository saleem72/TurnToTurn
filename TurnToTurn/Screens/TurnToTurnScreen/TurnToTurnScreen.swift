//
//  TurnToTurnScreen.swift
//  TurnToTurn
//
//  Created by Yousef on 5/18/22.
//

import SwiftUI
import MapKit

struct TurnToTurnScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var manager: MapManager
    @State private var showSteps: Bool = false
    @State private var showStatistics: Bool = false
    
    var body: some View {
        ZStack {
            BackgroundView()
            content
            possibleLoading()
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showSteps, content: stepsView)
        .onDisappear(perform: manager.removeAllMonitoredRegins)
    }
}

extension TurnToTurnScreen {
    private func stepsView() -> some View {
        StepsListView()
    }
    
    private var content: some View {
        VStack {
            header
            if !manager.isInstructionLoading {
                contentDetails
            } else {
                Spacer()
            }
        }
    }
    
    private var contentDetails: some View {
        VStack {
            directionsSteps()
            mapSection
        }
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.manager.tellFirstStep()
            }
        }
    }
    
    private var mapSection: some View {
        
        ZStack {
            MapView(manager: manager) { _ in }
                .edgesIgnoringSafeArea(.bottom)
            
            MapCenterIndicator()
            
            ZStack(alignment: .topTrailing) {
                rightToolbar
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            
            ZStack(alignment: .topTrailing) {
                statisticsSection()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            
               
        }
    }
    
    @ViewBuilder
    private func statisticsSection() -> some View {
        if let details = manager.tripDetails, showStatistics {
            BottomSheetNotificationView(isVisible: $showStatistics) {
                VStack {
                    statisticsDetailsSection(details: details)
                    endButton
                }
            }
        }
    }
    
    private var searchButton: some View {
        Button(action: {
            showSteps = true
        }, label: {
            Image(systemName: "magnifyingglass")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .foregroundColor(.primary)
                .roundedButton()
        })
    }
    
    private var volumButton: some View {
        Button(action: {
            manager.tellFirstStep()
        }, label: {
            Image(systemName: "speaker.wave.2.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .foregroundColor(.primary)
                .roundedButton()
        })
    }
    
    private var locationButton: some View {
        Button(action: {
            withAnimation(.easeIn) {
                showStatistics.toggle()
            }
        }, label: {
            Image(systemName: "location.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .foregroundColor(.primary)
                .roundedButton()
        })
    }
    
    private var rightToolbar: some View {
        VStack {
            searchButton
            volumButton
            locationButton
        }
        .padding()
        .padding(.trailing,8)
    }
    
    @ViewBuilder
    private func directionsSteps() -> some View {
        if manager.directions.count > 0 {
            DirectionsStepsView(directions: manager.directions, currentIndex: $manager.topStepIndex)
        }
    }
    
    private var header: some View {
        NavHeaderView(label: "") { }
    }
    
    @ViewBuilder
    private func possibleLoading() -> some View {
        if manager.isInstructionLoading {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.palette.red))
                .scaleEffect(3)
        }
    }
    
    private func statisticsDetailsSection(details: TripDetails) -> some View {
        HStack {
            TripStatisticsLabel(value: details.end.shortTime, label: "Arrival")
            
            Spacer(minLength: 0)
            TripStatisticsLabel(value: details.expectedTravelTime.toMinutes, label: "min")
            Spacer(minLength: 0)
            let distance = details.distance.towLinesDistance
            TripStatisticsLabel(value: distance.value, label: distance.unit)
        }
        .multilineTextAlignment(.center)
        .padding()
    }
    
    private var endButton: some View {
        Button(action: {
            withAnimation(.easeIn) {
                showStatistics = false
            }
        }, label: {
            HStack {
                Image(systemName: "location.north.fill")
                    .font(Font.gallery.headline)
                    .foregroundColor(Color.white)
                
                Text("Start")
                    .font(Font.gallery.bold(17))
                    .foregroundColor(Color.white)
            }
            .gradientWithIconButton()
        })
        .frame(width: 150)
    }
    
}


struct TurnToTurnScreen_Previews: PreviewProvider {
    static var previews: some View {
        TurnToTurnScreen()
            .preferredColorScheme(.dark)
            .environmentObject(MapManager())
    }
}
