//
//  SidebarView.swift
//  ReleaseRocket
//
//  Created by Voxpopme on 25/09/2024.
//

import SwiftUI

struct SidebarView: View {
    var projects: [Project]                                // Project list
    @Binding var selectedProject: Project?                 // Binding to the selected project
    var onAddProject: () -> Void                           // Callback for adding a new project
    var onDeleteProject: (IndexSet) -> Void                // Callback for deleting projects

    var body: some View {
        List(selection: $selectedProject) {                // Bind project selection
            Section {
                // New Project Button
                Button(action: onAddProject) {
                    Label("New Project", systemImage: "plus")
                        .padding(.horizontal, 12)            // Padding around the text and icon
                        .padding(.vertical, 8)               // Vertical padding for better height
                        .background(Color.red)               // Red background
                        .foregroundColor(.white)             // White text and icon
                        .cornerRadius(10)                    // Rounded corners
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)  // Subtle shadow for depth
                }
                .buttonStyle(PlainButtonStyle())             // Remove default button styling
            }
            Section(header: Text("Projects")) {
                ForEach(projects) { project in
                    Label {
                        Text("\(project.name) (\(project.platform))")  // Project name and platform
                    } icon: {
                        Image(systemName: "folder")  // System image for folder icon
                            .foregroundColor(.gray)  // Customize icon color
                    }
                    .tag(project)  // Tag each project to track selection
                    .contextMenu {  // Add context menu for right-click options
                        Button(action: {
                            if let index = projects.firstIndex(of: project) {
                                onDeleteProject(IndexSet(integer: index))  // Call the delete function
                            }
                        }) {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
                .onDelete(perform: onDeleteProject)  // Delete projects via callback (for swipe-to-delete)
            }
        }
        .listStyle(SidebarListStyle())                     // Make the list a sidebar style
        .navigationTitle("Projects")
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        // Sample project list for the preview
        let sampleProjects = [
            Project(name: "Sample Project 1", version: "1.0", build: "100", releaseNotes: "Initial Release"),
            Project(name: "Sample Project 2", version: "1.1", build: "101", releaseNotes: "Bug Fixes"),
            Project(name: "Sample Project 3", version: "1.2", build: "102", releaseNotes: "New Features")
        ]

        SidebarView(
            projects: sampleProjects,                              // Pass sample projects
            selectedProject: .constant(sampleProjects.first),      // Bind selection to the first project
            onAddProject: {
                print("New project added!")                        // Placeholder for adding a project
            },
            onDeleteProject: { indexSet in
                print("Deleted project at index \(indexSet)")      // Placeholder for deletion
            }
        )
        .modelContainer(for: Project.self, inMemory: true)         // Use an in-memory model container for SwiftData
        .previewLayout(.sizeThatFits)                              // Adjust the layout for preview
    }
}


