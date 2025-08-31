//
//  Tokenizer.swift
//  ReadBuddy
//
//  Created by Sam Kinred on 2025/08/31.
//


import Foundation

enum Tokenizer {
    static func splitIntoSentences(text: String) -> [Sentence] {
        var result: [Sentence] = []
        var start = text.startIndex
        let delimiters = CharacterSet(charactersIn: ".!?")
        var i = start

        while i < text.endIndex {
            if let scalar = text[i].unicodeScalars.first, delimiters.contains(scalar) {
                let end = text.index(after: i)
                let range = start..<end
                let sentenceText = text[range].trimmingCharacters(in: .whitespacesAndNewlines)
                if !sentenceText.isEmpty {
                    result.append(Sentence(text: sentenceText, range: range))
                }
                // move start to next non-space
                start = nextNonSpace(in: text, from: end) ?? end
                i = start
                continue
            }
            i = text.index(after: i)
        }
        if start < text.endIndex {
            let range = start..<text.endIndex
            let tail = text[range].trimmingCharacters(in: .whitespacesAndNewlines)
            if !tail.isEmpty {
                result.append(Sentence(text: tail, range: range))
            }
        }
        return result
    }

    static func tokenize(sentence: Sentence) -> [Token] {
        sentence.text.split(whereSeparator: { $0.isWhitespace }).map { word in
            let surface = String(word)
            let normalized = surface
                .lowercased()
                .trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            return Token(surface: surface, normalized: normalized)
        }
    }

    private static func nextNonSpace(in text: String, from idx: String.Index) -> String.Index? {
        var i = idx
        while i < text.endIndex {
            if !text[i].isWhitespace { return i }
            i = text.index(after: i)
        }
        return nil
    }
}
