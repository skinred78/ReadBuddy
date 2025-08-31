//
//  StoryLoader.swift
//  ReadBuddy
//
//  Created by Sam Kinred on 2025/08/31.
//


import Foundation

enum StoryLoader {
    static func loadBundledStory(named: String) -> String? {
        guard let url = Bundle.main.url(forResource: named, withExtension: "txt", subdirectory: "Stories") ??
                        Bundle.main.url(forResource: named, withExtension: "txt") else {
            return nil
        }
        return try? String(contentsOf: url)
    }
}
