//
//  AVSpeechSynthesizer.swift
//  TurnToTurn
//
//  Created by Yousef on 5/19/22.
//

import Foundation
import AVFoundation

extension AVSpeechSynthesizer {
    func speak(_ message: String) {
        let utterance = AVSpeechUtterance(string: message)
        utterance.voice = AVSpeechSynthesisVoice(language: Voice.moira.rawValue)
        self.usesApplicationAudioSession = true
        self.speak(utterance)
    }
}
