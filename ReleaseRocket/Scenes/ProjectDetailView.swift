//
//  ProjectDetailView.swift
//  ReleaseRocket
//
//  Created by Voxpopme on 25/09/2024.
//

import SwiftUI

struct ProjectDetailView: View {
    @Binding var project: Project  // Use @Binding for two-way binding
    var onSend: () -> Void          // Callback for when the Send button is pressed

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
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())  // Use Segmented style or default dropdown style
                    
                    Text("Project Name")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    TextField("App Name", text: $project.name)  // Two-way binding for editing
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                }
                .padding(.bottom, 16)
                
                

                Divider()  // Divider between sections

                // Version and Build Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Version & Build")
                        .font(.headline)
                        .foregroundColor(.white)

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
                        ForEach(["Bug Fix", "Maintenance", "Software Health", "Story", "Feature", "Refactor", "Other"], id: \.self) { featureType in
                            Text(featureType).tag(featureType)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(MenuPickerStyle())  // Use Menu style dropdown

                    TextEditor(text: $project.releaseNotes)  // Native SwiftUI TextEditor
                        .frame(height: 100)
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color(red: 30/255, green: 30/255, blue: 30/255)))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.9), lineWidth: 1))  // Add the border
                }
                .padding(.bottom, 16)

                Divider()  // Divider between sections

                // Notify Option
                VStack(alignment: .leading, spacing: 8) {
                    Text("Notify")
                        .font(.headline)
                        .foregroundColor(.white)

                    Picker("Notify Option", selection: $project.notifyOption) {
                        ForEach(["none", "channel", "here"], id: \.self) { notifyOption in
                            Text("@\(notifyOption)").tag(notifyOption)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())  // Use Segmented style or default dropdown style
                }
                .padding(.bottom, 16)

                // Send Button
                Button(action: onSend) {
                    Text("Send")
                        .frame(height: 5)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.top, 16)  // Add some padding on top
            }
            .padding()
            .cornerRadius(12)
            .shadow(radius: 10)
            .padding()
        }  // End of ScrollView
    }
}



// MARK: - Preview for ProjectDetailView
struct ProjectDetailView_Previews: PreviewProvider {
    @State static var sampleProject = Project(
        name: "Sample Project",
        version: "1.0.0",
        build: "100",
        releaseNotes: "Initial release notes",
        platform: "iOS",
        author: "John Doe",
        featureType: "Feature",
        notifyOption: "None"
    )

    static var previews: some View {
        ProjectDetailView(project: $sampleProject, onSend: {
            print("Send button pressed")
        })
        .background(Color.black)  // Background color to match the white text
        .frame(width: 600, height: 700)  // Set custom width and height for the preview
        .previewLayout(.sizeThatFits)  // Ensures it fits the screen during preview
    }
}

