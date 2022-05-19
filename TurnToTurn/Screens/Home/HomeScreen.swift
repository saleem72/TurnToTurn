//
//  HomeScreen.swift
//  TurnToTurn
//
//  Created by Yousef on 5/18/22.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject private var viewModel: HomeViewModel = .init()
    @EnvironmentObject private var manager: MapManager
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundLayer
                content
                possibleLocationError()
            }
            .navigationBarHidden(true)
            .onAppear(perform: manager.checkIfLocationServiceEnabled)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
            .preferredColorScheme(.dark)
            .environmentObject(MapManager())
    }
}

private extension HomeScreen {
    
    private var backgroundLayer: some View {
        LinearGradient.screen
            .overlay(teslaImage)
            .overlay(blurLayer)
            .overlay(wavesLayer)
            .overlay(locationHugeIcon)
            .edgesIgnoringSafeArea(.all)
    }
    
    private var navLinks: some View {
        VStack {
            NavigationLink(
                "",
                destination: SelectLocationScreen(addTo: .source),
                isActive: $viewModel.gotoMapSelectionSource
            )
            
            NavigationLink(
                "",
                destination: SelectLocationScreen(addTo: .destination),
                isActive: $viewModel.gotoMapSelectionDestination
            )
            
            NavigationLink(
                "",
                destination: TurnToTurnScreen(),
                isActive: $viewModel.gotoMapInstructions
            )
        }
    }
    
    private var content: some View {
        VStack {
            
            header
            
            Text("Where are you going today?")
                .font(Font.gallery.regular(20))
                .foregroundColor(Color.palette.secondary)
            
            VStack {
                locationBar
                destinationBar
                tripActionButtons
                    .padding(.top)
            }
            .padding()
            
            Spacer(minLength: 0)
        }
        .background(navLinks)
    }
    
    private var header: some View {
        HStack {
            Button(action: {}, label: {
                UserImageView()
            })
            .padding(.leading)
        }
        .frame(height: 62)
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(greetingMessage)
    }
    
    private var greetingMessage: some View {
        Text("Hello, Sourany")
            .font(Font.gallery.headline())
            .foregroundColor(Color.palette.primary)
    }
    
    private var selectSourceButton: some View {
        Button(action: {
            viewModel.gotoMapSelectionSource = true
        }, label: {
            Image(systemName: "ellipsis")
                .font(Font.gallery.headline())
                .foregroundColor(Color.palette.secondary)
                .frame(width: 44, height: 44)
        })
    }
    
    private var selectSourceText: some View {
        Group {
            if let location = manager.sourceLocation {
                Text(location.name)
            } else if let _ = manager.userLocation {
                Text("Current Location")
            } else {
                Text("N/A")
            }
        }
        .thickLabel()
    }
    
    private var locationBar: some View {
        HStack {
            LocationIcon()
                .frame(width: 44, height: 44)
            selectSourceText
            selectSourceButton
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var selectDestinationText: some View {
        Group {
            if let location = manager.destinationLocation {
                Text(location.name)
            } else {
                Text("Not set yet")
            }
        }
        .thickLabel()
    }
    
    private var selectDestinationButton: some View {
        Button(action: {
            viewModel.gotoMapSelectionDestination = true
        }, label: {
            Image(systemName: "shuffle")
                .font(Font.gallery.headline())
                .foregroundColor(Color.palette.secondary)
                .frame(width: 44, height: 44)
        })
    }
    
    private var destinationBar: some View {
        HStack {
            DestinationIcon()
                .frame(width: 44, height: 44)
            selectDestinationText
            selectDestinationButton
        }
    }
    
    private var stepsButton: some View {
        Button(action: {}, label: {
            HStack {
                Image(systemName: "list.bullet")
                    .font(Font.gallery.headline())
                    .foregroundColor(Color.primary)
                
                Text("Steps")
                    .font(Font.gallery.bold(17))
                    .foregroundColor(Color.palette.primary)
            }
            .strokeWithIconButton()
        })
    }
    
    private var startTripButton: some View {
        Button(action: {
            manager.calculateRoute()
        }, label: {
            HStack {
                Image(systemName: "location.north.fill")
                    .font(Font.gallery.headline())
                    .foregroundColor(Color.primary)
                
                Text("Start")
                    .font(Font.gallery.bold(17))
                    .foregroundColor(Color.palette.primary)
            }
            .gradientWithIconButton()
        })
        .disabled(!manager.isTripReady)
        .opacity(manager.isTripReady ? 1 : 0.6)
    }
    
    private var pinButton: some View {
        Button(action: {}, label: {
            HStack {
                Image(systemName: "list.bullet")
                    .font(Font.gallery.headline())
                    .foregroundColor(Color.primary)
                
                Text("Pin")
                    .font(Font.gallery.bold(17))
                    .foregroundColor(Color.palette.primary)
            }
            .strokeWithIconButton()
        })
    }
    
    private var tripActionButtons: some View {
        HStack(spacing: 8){
            stepsButton
            startTripButton
            pinButton
        }
        .frame(height: 38)
        .frame(maxWidth: .infinity)
    }
    
    private var blurLayer: some View {
        ZStack {
            Ellipse()
            .fill(AngularGradient(
                    gradient: Gradient(stops: [
                .init(color: Color(#colorLiteral(red: 0.2633333206176758, green: 0.64089035987854, blue: 0.987500011920929, alpha: 1)), location: 0.14994069933891296),
                .init(color: Color(#colorLiteral(red: 0.6176667213439941, green: 0.38333332538604736, blue: 1, alpha: 1)), location: 0.3641078472137451),
                .init(color: Color(#colorLiteral(red: 0.24480903148651123, green: 0.7176761627197266, blue: 0.9958333373069763, alpha: 1)), location: 0.5341951847076416),
                .init(color: Color(#colorLiteral(red: 0.047916680574417114, green: 0.22874994575977325, blue: 0.5, alpha: 1)), location: 0.8459962010383606)]),
                    center: UnitPoint(x: 0.5, y: 0.49999999999999994)
                  ))
                .blur(radius: 150)
        }
        .frame(width: 274, height: 204)
        .clipped()
        .offset(y: 200)
    }
    
    private var teslaImage: some View {
        ZStack {
            VStack {
                Spacer()
                
                Image("Road")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            VStack {
                Spacer()
                Image("Tesla-2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .offset(y: -10)
            }
        }
    }
    
    private var wavesLayer: some View {
        VStack {
            Spacer()
            Image("LooperGroup")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.6)
        }
    }
    
    private var locationHugeIcon: some View {
        LocationHugeIcon()
            .offset(y: 40)
    }
    
    @ViewBuilder
    private func possibleLocationError() -> some View {
        if let _ = manager.locationError {
            ErrorView(error: $manager.locationError)
        }
    }
}
