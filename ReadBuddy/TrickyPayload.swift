//
//  TrickyPayload.swift
//  ReadBuddy
//
//  Created by Sam Kinred on 2025/08/31.
//


import Foundation

struct TrickyPayload: Codable {
    let storyId: String
    let words: [String]
}

final class PersistenceService {
    private func appSupportURL() -> URL? {
        FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first
    }

    private func fileURL(storyId: String) -> URL? {
        guard let base = appSupportURL() else { return nil }
        let dir = base.appendingPathComponent("ReadBuddy", isDirectory: true)
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir.appendingPathComponent("tricky_words_\(storyId).json")
    }

    func loadTrickyWords(storyId: String) -> Set<String> {
        guard let url = fileURL(storyId: storyId),
              let data = try? Data(contentsOf: url),
              let payload = try? JSONDecoder().decode(TrickyPayload.self, from: data) else {
            return []
        }
        return Set(payload.words)
    }

    func saveTrickyWords(_ words: [String], storyId: String) {
        guard let url = fileURL(storyId: storyId) else { return }
        let payload = TrickyPayload(storyId: storyId, words: words.sorted())
        if let data = try? JSONEncoder().encode(payload) {
            try? data.write(to: url, options: .atomic)
        }
    }
}
