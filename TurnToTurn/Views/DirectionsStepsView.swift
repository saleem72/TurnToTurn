//
//  DirectionsStepsView.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/12/22.
//

import SwiftUI
import MapKit

struct DirectionsStepsView: View {
    
    var directions: [MapStep]
    @Binding var currentIndex: Int?
    
    @State var flip: Bool = false
    @State var animatedText: Bool = false
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            firstStepSection()
            secondStepSection()
            
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .onChange(of: currentIndex, perform: { _ in
            flipItems()
        })
        .contentShape(Rectangle())
        .onTapGesture {
            flipItems()
        }
    }
}

//struct DirectionsStepsView_Previews: PreviewProvider {
//    static var manager: MapManager = {
//        let manager = MapManager()
//        manager.mockTrip()
//        return manager
//    }()
//
//    static var previews: some View {
//        DirectionsStepsView(route: MapRoute())
//            .environmentObject(manager)
//    }
//}

extension DirectionsStepsView {
    @ViewBuilder
    private func firstStepSection() -> some View {
        if let currentIndex = currentIndex, currentIndex < directions.count {
            let firstStep = directions[currentIndex]
            HStack {
                Image(firstStep.stepType.icon)
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color.palette.blue)
                    .padding(.leading)
                
                VStack(alignment: .leading) {
                    Text(firstStep.stepType.title)
                        .font(.headline)
                        .foregroundColor(Color.palette.primary)
                    
                    Text(firstStep.instructions)
                        .font(.caption)
                        .foregroundColor(Color.palette.secondary)
                }
                .padding()
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(firstStep.distance.toDistance)
                    .foregroundColor(.white)
                    .blinking()
                    .padding(.trailing)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                CustomRoundedShape(corners: flip ? [.bottomLeft, .bottomRight] : [.topLeft, .topRight])
                    // Color.fromHexString("#2C2C2E").opacity(0.35)
                    .fill(Color.fromHexString("#2C2C2E").opacity(0.35))
                    .rotation3DEffect(
                        Angle(degrees: flip ? 180 : 0),
                        axis: (x: 1, y: 0, z: 0))
            )
        }
        
    }
    
    func flipItems() {
        flip = false
        withAnimation(.easeIn(duration: 1.5)) {
            flip = true
        }
    }
    
    @ViewBuilder
    private func secondStepSection() -> some View {
        if  let currentIndex = currentIndex, currentIndex + 1 < directions.count {
            let secondStep = directions[currentIndex + 1]
            HStack {
                Text("Then")
                    .font(.headline)
                Image(secondStep.stepType.icon)
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
            }
            .foregroundColor(.white)
            .padding()
            .background(
                CustomRoundedShape(corners: flip ? [.topLeft, .topRight] : [.bottomLeft, .bottomRight])
                    // Color.fromHexString("#2C2C2E").opacity(0.35)
                    .fill(Color.fromHexString("#2C2C2E"))
                    .rotation3DEffect(
                        Angle(degrees: flip ? 180 : 0),
                        axis: (x: 1, y: 0, z: 0))
            )
        }
    }
}



