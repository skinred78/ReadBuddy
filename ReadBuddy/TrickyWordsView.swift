//
//  TrickyWordsView.swift
//  ReadBuddy
//
//  Created by Sam Kinred on 2025/08/31.
//


import SwiftUI

struct TrickyWordsView: View {
    @ObservedObject var model: AppModel

    var sortedWords: [String] {
        model.trickyWords.sorted()
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Tricky Words")
                .font(.headline)
                .padding(.top, 8)

            if sortedWords.isEmpty {
                Text("No tricky words yet.")
                    .foregroundStyle(.secondary)
                    .padding(.vertical, 8)
            } else {
                List(sortedWords, id: \.self) { w in
                    Button {
                        // Find first occurrence sentence and speak
                        if let idx = model.tokensBySentence.firstIndex(where: { row in row.contains(where: { $0.normalized == w }) }) {
                            model.speakSentence(at: idx)
                            model.currentSentenceIndex = idx
                        }
                    } label: {
                        Text(w)
                    }
                }
            }

            Spacer()
        }
        .padding()
    }
}
