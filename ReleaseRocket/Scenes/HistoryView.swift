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
                    VStack(alignment: .leading) {
                        Text("Version: \(entry.version), Build: \(entry.build)")
                            .font(.subheadline)
                        Text(entry.releaseNotes)
                            .font(.body)
                        Text("Date: \(entry.date.formatted())")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom)
                }
            }
            .listStyle(PlainListStyle())
        }
        .padding()
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleHistory = [
            ReleaseHistory(projectName: "", version: "", build: "", releaseNotes: "", platform: "", author: "", featureType: "", notifyOption: "", date: Date()),
            ReleaseHistory(projectName: "", version: "", build: "", releaseNotes: "", platform: "", author: "", featureType: "", notifyOption: "", date: Date())
        ]
        
        return HistoryView(
            project: Project(name: "Sample Project", version: "1.0", build: "100", releaseNotes: "Initial release notes"),
            history: sampleHistory
        )
        .modelContainer(for: [Project.self, ReleaseHistory.self], inMemory: true) // Preview in-memory model container
    }
}


