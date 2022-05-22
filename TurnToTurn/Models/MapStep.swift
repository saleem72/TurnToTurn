//
//  MapStep.swift
//  TurnToTurn
//
//  Created by Yousef on 5/22/22.
//

import Foundation
import MapKit

struct MapStep: Identifiable {
    let id = UUID().uuidString
    let stepType: StepType
    
    private let step: MKRoute.Step
    
    init(step: MKRoute.Step) {
        self.step = step
        stepType = StepType.map(step.instructions)
    }
    
    var coordinate: CLLocationCoordinate2D {
        step.polyline.coordinate
    }
    
    var instructions: String {
        step.instructions
    }
    
    var distance: Double {
        step.distance
    }
    
    var notice: String? {
        step.notice
    }
    
    var voice: String {
        if let word = step.distance.asWord {
            return "in \(word) meters \(instructions)"  // stepType.title + " after " + word + " meter"
        } else {
            return "in \(step.distance.toDistance) \(instructions)" // stepType.title + " after " + distance.toDistance
        }
    }
}

extension MapStep: Equatable {
    static func ==(lhs: MapStep, rhs: MapStep) -> Bool {
        lhs.coordinate == rhs.coordinate
    }
}

extension MapStep {
    enum StepType {
        case turnRight
        case turnLeft
        case takeSlightLeft
        case takeSlightRight
        case arriveRight
        case arriveLeft
        case arriveStraight
        case keepLeft
        case keepRight
        case unknown
        
        var icon: String {
            switch self {
            case .turnRight: return "arrive_right"
            case .turnLeft: return "depart_left"
            case .takeSlightLeft: return "slight_left"
            case .takeSlightRight: return "slight_right"
            case .arriveRight: return "arrive_right"
            case .arriveLeft: return "arrive_left"
            case .arriveStraight: return "arrive_straight"
            case .keepLeft: return "keep_left_us"
            case .keepRight: return "keep_right"
            case .unknown: return "flag"
            }
        }
        
        var title: String {
            switch self {
            case .turnRight: return "Turn right"
            case .turnLeft: return "Turn left"
            case .takeSlightLeft: return "Take slight left"
            case .takeSlightRight: return "Take slight right"
            case .arriveRight: return "Arrive right"
            case .arriveLeft: return "Arrive left"
            case .arriveStraight: return "Arrive straight"
            case .keepLeft: return "Keep left"
            case .keepRight: return "Keep right"
            case .unknown: return "flag"
            }
        }
        
        static func map(_ step: String) -> StepType {
            if step.uppercased().hasPrefix("Turn right".uppercased()) {
                return .turnRight
            } else if step.uppercased().hasPrefix("Turn left".uppercased()) {
                return .turnLeft
            } else if step.uppercased().hasPrefix("Take a slight left".uppercased()) {
                return .takeSlightLeft
            } else if step.uppercased().hasPrefix("Take a slight right".uppercased()) {
                return .takeSlightRight
            } else if step.uppercased().hasPrefix("Keep left".uppercased()) {
                return .keepLeft
            } else if step.uppercased().hasPrefix("Keep right".uppercased()) {
                return .keepRight
            } else if step.uppercased().hasPrefix("The destination is on your right".uppercased()) {
                return .arriveRight
            } else if step.uppercased().hasPrefix("The destination is on your left".uppercased()) {
                return .arriveLeft
            } else if step.uppercased().hasPrefix("The destination is on your straight".uppercased()) {
                return .arriveStraight
            }
            else {
                return .unknown
            }
        }
    }
    
    
}
