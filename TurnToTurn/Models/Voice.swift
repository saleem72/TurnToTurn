//
//  Voice.swift
//  TurnToTurn
//
//  Created by Yousef on 5/19/22.
//

import Foundation
import AVFoundation

enum Voice: String, CaseIterable {
    case karen = "en-AU"
    case daniel = "en-GB"
    case moira = "en-IE"
    case samantha = "en-US"
    case tessa = "en-ZA"
    
    var language: String {
        switch self {
        case .karen: return "Karen"
        case .daniel: return "Daniel"
        case .moira: return "Moira"
        case .samantha: return "Samantha"
        case .tessa: return "Tessa"
        }
    }
}



