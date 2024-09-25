//
//  ProjectDetailView.swift
//  ReleaseRocket
//
//  Created by Voxpopme on 25/09/2024.
//

import SwiftUI

struct ProjectDetailView: View {
 
    @Binding var project: Project  // Use @Binding for two-way binding
    
    var body: some View {
        ScrollView {  // Make the whole view scrollable
            VStack(alignment: .leading, spacing: 16) {
                // Platform Selection - Moved to the top
                VStack(alignment: .leading, spacing: 8) {
                    Text("Platform")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Picker("Select Platform", selection: $project.platform) {
                        ForEach(["iOS", "Android", "Web", "Backend"], id: \.self) { platform in
                            Text(platform).tag(platform)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())  // Use Segmented style or default dropdown style
                }
                .padding(.bottom, 16)
                
                // Project Name, Version, Build
                VStack(alignment: .leading, spacing: 8) {
                    Text("Name")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    TextField("App Name", text: $project.name)  // Two-way binding for editing
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    // Version and Build side by side
                    HStack(spacing: 16) {
                        VStack(alignment: .leading) {
                            Text("Version")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            TextField("Version", text: $project.version)  // Two-way binding
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Build")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            TextField("Build", text: $project.build)  // Two-way binding
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                }
                .padding(.bottom, 16)
                
                Divider()  // Divider between sections
                
                // Release Notes Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Release Notes")
                        .font(.headline)
                        .foregroundColor(.white)
                    TextField("Author Name", text: $project.author)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Picker("", selection: $project.featureType) {
                        ForEach(["Bug Fix", "Maintenance", "Software Health", "Story", "Feature", "Refactor"], id: \.self) { featureType in
                            Text(featureType).tag(featureType)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(MenuPickerStyle())  // Use Menu style dropdown
                    TextEditor(text: $project.releaseNotes)  // Native SwiftUI TextEditor
                            .frame(height: 100)
                            .padding(8)  // Add padding around the TextEditor
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5), lineWidth: 1))
                }
                .padding(.bottom, 16)
                
                Divider()  // Divider between sections
                

                // Notify Option
                VStack(alignment: .leading, spacing: 8) {
                    Text("Notify")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Picker("Notify Option", selection: $project.notifyOption) {
                        ForEach(["None", "@channel", "@here"], id: \.self) { notifyOption in
                            Text(notifyOption).tag(notifyOption)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())  // Use Segmented style or default dropdown style
                }
                .padding(.bottom, 16)
                
            }
            .padding()
            .cornerRadius(12)
            .shadow(radius: 10)
            .padding()
        }  // End of ScrollView
    }
}






//struct ProjectDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProjectDetailView(
//            project: Project(
//                name: "Sample Project",
//                version: "1.0",
//                build: "100",
//                releaseNotes: "Initial release notes"
//            )
//        )
//        .modelContainer(for: [Project.self], inMemory: true) // Preview in-memory model container
//    }
//}
