//
//  OtteratorApp.swift
//  Otterator
//
//  Created by Christopher Julius on 12/07/24.
//

import SwiftUI
import SwiftData
import AVFoundation

@main
struct OtteratorApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    var body: some Scene {
        WindowGroup {
            TranscriptView()
        }
        .modelContainer(sharedModelContainer)
    }
}
