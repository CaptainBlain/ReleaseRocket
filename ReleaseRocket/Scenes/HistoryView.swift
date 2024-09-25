//
//  HistoryView.swift
//  ReleaseRocket
//
//  Created by Voxpopme on 25/09/2024.
//

import SwiftUI

struct HistoryView: View {
    var project: Project
    var history: [ReleaseHistory]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Release History")
                .font(.headline)
                .padding(.bottom)

            List {
                ForEach(history.filter { $0.projectName == project.name }) { entry in
                    VStack(alignment: .leading, spacing: 4) {
                        // Version and Build Information
                        Text("\(entry.projectName) (\(entry.platform))")
                            .font(.subheadline)
                            .bold()
                        // Version and Build Information
                        Text("Version: \(entry.version), Build: \(entry.build)")
                            .font(.subheadline)
                            .bold()

                        // Author Information
                        Text("Author: \(entry.author)")
                            .font(.footnote)
                            .foregroundColor(.secondary)

                        // Feature Type
                        Text("Feature Type: \(entry.featureType)")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        
                        // Release Notes
                        Text(entry.releaseNotes)
                            .font(.body)

                        // Date of the Release
                        Text("Date: \(entry.date.formatted())")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 4)  // Add spacing between history entries
                }
            }
            .listStyle(PlainListStyle())
        }
        .padding()
    }
}

// MARK: - PreviewProvider
struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        // Example Project
        let project = Project(
            name: "Influence",
            version: "9.12.0",
            build: "19340",
            releaseNotes: "Test release",
            platform: "iOS",
            author: "John Doe",
            featureType: "Feature",
            notifyOption: "@channel"
        )

        // Example Release History Entries
        let sampleHistory = [
            ReleaseHistory(projectName: "Influence", version: "9.12.0", build: "19340", releaseNotes: "Initial release", platform: "iOS", author: "John Doe", featureType: "Story", notifyOption: "@channel", date: Date()),
            ReleaseHistory(projectName: "Influence", version: "9.12.1", build: "19341", releaseNotes: "Bug fix release", platform: "Android", author: "Jane Smith", featureType: "Bug Fix", notifyOption: "None", date: Date()),
            ReleaseHistory(projectName: "Influence", version: "9.13.0", build: "19350", releaseNotes: "Major feature update", platform: "Web", author: "Alice", featureType: "Feature", notifyOption: "@here", date: Date())
        ]

        // Displaying the HistoryView with a mock project and history data
        return HistoryView(project: project, history: sampleHistory)
            .frame(width: 400, height: 400)  // Example frame size for preview
    }
}


