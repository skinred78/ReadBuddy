//
//  ContentView 2.swift
//  ReadBuddy
//
//  Created by Sam Kinred on 2025/08/31.
//


import SwiftUI

struct ContentView: View {
    @ObservedObject var model: AppModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(Array(model.sentences.enumerated()), id: \.0) { (idx, sentence) in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 8) {
                            Button {
                                model.speakSentence(at: idx)
                            } label: {
                                Label("Speak sentence", systemImage: "play.fill")
                                    .labelStyle(.iconOnly)
                            }
                            .buttonStyle(.bordered)

                            Text("Sentence \(idx + 1)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        FlowWordsView(tokens: model.tokensBySentence[idx],
                                      model: model)
                    }
                    .padding(.vertical, 6)
                    .onTapGesture {
                        model.currentSentenceIndex = idx
                    }
                    Divider()
                }
            }
            .padding(16)
        }
        .navigationTitle("ReadBuddy")
        .environment(\.sizeCategory, model.largeText ? .accessibilityExtraExtraExtraLarge : .large)
    }
}

struct FlowWordsView: View {
    let tokens: [Token]
    @ObservedObject var model: AppModel
    @State private var lastTappedId: Token.ID? = nil

    var body: some View {
        // Simple wrap using LazyVGrid with flexible columns for large hit areas
        LazyVGrid(columns: [GridItem(.flexible(minimum: 44)),
                            GridItem(.flexible(minimum: 44)),
                            GridItem(.flexible(minimum: 44)),
                            GridItem(.flexible(minimum: 44))],
                  alignment: .leading, spacing: 8) {
            ForEach(tokens) { token in
                WordBubble(token: token,
                           isHighlighted: token.id == lastTappedId,
                           isTricky: model.trickyWords.contains(token.normalized))
                .onTapGesture {
                    lastTappedId = token.id
                    model.speak(word: token.surface.trimmingCharacters(in: .punctuationCharacters))

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        if lastTappedId == token.id {
                            withAnimation(.easeOut(duration: 0.2)) {
                                lastTappedId = nil
                            }
                        }
                    }
                }
                .onLongPressGesture(minimumDuration: 0.35) {
                    model.toggleTricky(word: token.normalized)
                }
            }
        }
    }
}

struct WordBubble: View {
    let token: Token
    let isHighlighted: Bool
    let isTricky: Bool

    var body: some View {
        Text(token.surface)
            .padding(.vertical, 6)
            .padding(.horizontal, 10)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(isHighlighted ? Color.accentColor.opacity(0.25) : Color.secondary.opacity(0.15))
            }
            .overlay(alignment: .topTrailing) {
                if isTricky {
                    Image(systemName: "star.fill")
                        .font(.caption2)
                        .foregroundStyle(.yellow)
                        .offset(x: 6, y: -6)
                }
            }
            .animation(.easeOut(duration: 0.15), value: isHighlighted)
    }
}
