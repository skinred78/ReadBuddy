//
//  AppModel.swift
//  ReadBuddy
//
//  Created by Sam Kinred on 2025/08/31.
//


import Foundation
import AVFoundation

final class AppModel: ObservableObject {
    // Story
    @Published var storyText: String = StoryLoader.loadBundledStory(named: "sample_1") ?? "No story found."
    @Published var sentences: [Sentence] = []
    @Published var tokensBySentence: [[Token]] = []

    // UI state
    @Published var trickyWords: Set<String> = []
    @Published var lastSpokenWord: String? = nil
    @Published var currentSentenceIndex: Int? = nil

    // Settings
    @Published var speechRate: Float = 0.48
    @Published var speechPitch: Float = 1.0
    @Published var largeText: Bool = true

    private let speech = SpeechService()
    private let store = PersistenceService()

    init() {
        tokenize()
        loadTricky()
    }

    func tokenize() {
        sentences = Tokenizer.splitIntoSentences(text: storyText)
        tokensBySentence = sentences.map { Tokenizer.tokenize(sentence: $0) }
    }

    func speak(word: String) {
        lastSpokenWord = word
        speech.speak(text: word, rate: speechRate, pitch: speechPitch)
    }

    func speakSentence(at idx: Int) {
        guard sentences.indices.contains(idx) else { return }
        currentSentenceIndex = idx
        speech.speak(text: sentences[idx].text, rate: speechRate, pitch: speechPitch)
    }

    func speakCurrentSentence() {
        if let i = currentSentenceIndex { speakSentence(at: i) }
        else { speakSentence(at: 0) }
    }

    func speakLastWord() {
        if let w = lastSpokenWord { speak(word: w) }
    }

    func toggleTricky(word: String) {
        if trickyWords.contains(word) { trickyWords.remove(word) }
        else { trickyWords.insert(word) }
        saveTricky()
    }

    private func storyId() -> String { "sample_1" }

    func loadTricky() {
        trickyWords = store.loadTrickyWords(storyId: storyId())
    }

    func saveTricky() {
        store.saveTrickyWords(Array(trickyWords), storyId: storyId())
    }
}
