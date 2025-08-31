//
//  SpeechService.swift
//  ReadBuddy
//
//  Created by Sam Kinred on 2025/08/31.
//


import AVFoundation

final class SpeechService {
    private let synth = AVSpeechSynthesizer()

    func speak(text: String, rate: Float, pitch: Float) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = rate
        utterance.pitchMultiplier = pitch
        synth.speak(utterance)
    }
}
