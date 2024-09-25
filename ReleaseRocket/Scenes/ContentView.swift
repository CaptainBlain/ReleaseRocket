//
//  ContentView.swift
//  ReleaseRocket
//
//  Created by Voxpopme on 25/09/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query private var projects: [Project]
    @Query private var settings: [AppSettings]
    @Query private var history: [ReleaseHistory]
    @ObservedObject var viewModel = AppViewModel()
    
    @State private var showingSettings = false          // To show the settings modal
    @State private var selectedProject: Project?        // To track the selected project
    @State private var showingAlert = false             // State to control alert visibility
    @State private var alertMessage = ""                // Message to show in the alert
    
    var body: some View {
        NavigationView {
            // Sidebar for project selection and creation
            SidebarView(
                projects: projects,
                selectedProject: $selectedProject,
                onAddProject: addNewProject,
                onDeleteProject: deleteProject
            )
            
            // Main Panel: Project Details and History (Two-panel layout)
            if let selectedProject = selectedProject {
                ProjectDetailSplitView(project: Binding(
                    get: { selectedProject },
                    set: { self.selectedProject = $0 }
                ), history: history)
                .frame(minWidth: 600, idealWidth: 800)
            } else {
                Text("Select a project to view details")
                    .frame(minWidth: 600, idealWidth: 800)
            }
        }
        .onAppear {
            loadLastSelectedProject()  // Load the last selected project on app launch
        }
        .onChange(of: selectedProject) {
            saveLastSelectedProject(selectedProject)  // Save the selected project when changed
        }
        .toolbar {
            // Send to Slack Button
            ToolbarItem(placement: .automatic) {
                Button(action: sendReleaseNotes) {
                    Label("Send to Slack", systemImage: "paperplane")
                }
                .disabled(selectedProject == nil)       // Disable if no project is selected
            }
            
            // Add the settings button in the toolbar
            ToolbarItem(placement: .automatic) {
                Button(action: { showingSettings.toggle() }) {
                    Label("Settings", systemImage: "gearshape")
                }
            }
        }
        .sheet(isPresented: $showingSettings) {
            SettingsView(isPresented: $showingSettings)
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .frame(minWidth: 800, minHeight: 600)
    }
    
    // Function to load the last selected project from UserDefaults
    private func loadLastSelectedProject() {
        if let lastSelectedProjectID = UserDefaults.standard.string(forKey: "LastSelectedProjectID") {
            // Try to find the project by its ID
            if let lastProject = projects.first(where: { $0.id.uuidString == lastSelectedProjectID }) {
                selectedProject = lastProject
            }
        }
    }
    
    // Function to save the selected project to UserDefaults
    private func saveLastSelectedProject(_ project: Project?) {
        if let project = project {
            UserDefaults.standard.set(project.id.uuidString, forKey: "LastSelectedProjectID")
        } else {
            UserDefaults.standard.removeObject(forKey: "LastSelectedProjectID")
        }
    }
    
    // Function to send release notes using the webhook URL for the selected project
    private func sendReleaseNotes() {
        guard let selectedProject = selectedProject else { return }
        
        if let appSettings = settings.first, !appSettings.slackWebhookURL.isEmpty {
            // Use the completion handler to determine if we should add to history
            viewModel.sendReleaseNotes(for: selectedProject, webhookURL: appSettings.slackWebhookURL) { success in
                if success {
                    // Add to the release history on success
                    DispatchQueue.main.async {
                        let newHistory = ReleaseHistory(
                            projectName: selectedProject.name,
                            version: selectedProject.version,
                            build: selectedProject.build,
                            releaseNotes: selectedProject.releaseNotes,
                            platform: selectedProject.platform,
                            author: selectedProject.author,
                            featureType: selectedProject.featureType,
                            notifyOption: selectedProject.notifyOption,
                            date: Date()  // Use the current date
                        )
                        context.insert(newHistory)
                        try? context.save()  // Save the new history entry
                    }
                } else {
                    // Show an error message or alert if the Slack message failed
                    DispatchQueue.main.async {
                        alertMessage = "Failed to send release notes to Slack."
                        showingAlert = true
                    }
                }
            }
        } else {
            // Show alert if Slack webhook URL is missing
            alertMessage = "Please add a Slack webhook in the settings."
            showingAlert = true
        }
    }
    
    // Function to delete a project
    private func deleteProject(at offsets: IndexSet) {
        for index in offsets {
            let project = projects[index]
            context.delete(project)                     // Delete from SwiftData context
        }
        try? context.save()                              // Persist the changes
    }
    
    // Function to automatically add a new project with default values
    private func addNewProject() {
        let newProject = Project(
            name: "New Project \(projects.count + 1)",  // Default project name
            version: "1.0",                             // Default version
            build: "100",                               // Default build number
            releaseNotes: "Initial release notes"       // Default release notes
        )
        context.insert(newProject)                      // Insert the new project into SwiftData context
        try? context.save()                             // Persist the new project
        
        // Automatically select the newly created project
        selectedProject = newProject
    }
}

