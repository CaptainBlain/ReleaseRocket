//
//  ProjectDetailSplitView.swift
//  ReleaseRocket
//
//  Created by Voxpopme on 25/09/2024.
//

import SwiftUI

struct ProjectDetailSplitView: View {
    @Binding var project: Project
    var history: [ReleaseHistory]
    var onSend: () -> Void
    
    var body: some View {
        HSplitView {
            // Left Panel: Project details
            ProjectDetailView(project: $project, onSend: onSend)  // Use @Binding to pass two-way binding
                .frame(minWidth: 400)

            // Right Panel: Release history
            HistoryView(project: project, history: history)
                .frame(minWidth: 200)
        }
    }
}


struct ProjectDetailSplitView_Previews: PreviewProvider {
    static var previews: some View {
        // Define a mutable @State variable for the project
        @State var sampleProject = Project(
            name: "Sample Project",
            version: "1.0",
            build: "100",
            releaseNotes: "Initial release notes"
        )
        
        let sampleHistory = [
            ReleaseHistory(projectName: "", version: "", build: "", releaseNotes: "", platform: "", author: "", featureType: "", notifyOption: "", date: Date()),
            ReleaseHistory(projectName: "", version: "", build: "", releaseNotes: "", platform: "", author: "", featureType: "", notifyOption: "", date: Date())
        ]
        
        return ProjectDetailSplitView(project: $sampleProject, history: sampleHistory, onSend: {}) // Pass the binding
            .modelContainer(for: [Project.self, ReleaseHistory.self], inMemory: true) // In-memory container for both models
    }
}
