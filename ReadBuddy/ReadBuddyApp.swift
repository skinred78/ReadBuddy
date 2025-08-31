import SwiftUI

@main
struct ReadBuddyApp: App {
    @StateObject private var appModel = AppModel()

    var body: some Scene {
        WindowGroup {
            NavigationSplitView {
                TrickyWordsView(model: appModel)
                    .frame(minWidth: 240)
            } detail: {
                ContentView(model: appModel)
            }
        }
        .commands {
            CommandMenu("Speak") {
                Button("Speak Current Sentence") { appModel.speakCurrentSentence() }
                    .keyboardShortcut("s", modifiers: [.command])
                Button("Speak Last Word") { appModel.speakLastWord() }
                    .keyboardShortcut("w", modifiers: [.command])
            }
        }

        Settings {
            SettingsView(model: appModel)
                .frame(width: 380)
        }
    }
}
