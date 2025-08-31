//
//  Sentence.swift
//  ReadBuddy
//
//  Created by Sam Kinred on 2025/08/31.
//


import Foundation

struct Sentence: Identifiable, Hashable {
    let id = UUID()
    let text: String
    let range: Range<String.Index>
}

struct Token: Identifiable, Hashable {
    let id = UUID()
    let surface: String      // shown text
    let normalized: String   // lowercased, no punctuation for matching
}
