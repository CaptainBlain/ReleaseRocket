//
//  ReleaseRocketApp.swift
//  ReleaseRocket
//
//  Created by Voxpopme on 25/09/2024.
//

import SwiftUI
import SwiftData

@main
struct ReleaseRocketApp: App {
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Project.self,
            ReleaseHistory.self,
            AppSettings.self
            
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
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
