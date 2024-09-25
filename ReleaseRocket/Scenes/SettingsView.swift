//
//  SettingsView.swift
//  ReleaseRocket
//
//  Created by Voxpopme on 25/09/2024.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.modelContext) private var context      // Model context for SwiftData
    @Query private var settings: [AppSettings]            // Fetch stored settings
    @Binding var isPresented: Bool                        // Binding to control sheet dismissal
    
    @State private var webhookURL: String = ""            // Local state for the webhook URL
    
    var body: some View {
        VStack(spacing: 16) { // Adjust the spacing between elements
            VStack(alignment: .leading) {
                Text("Slack Webhook URL")
                    .font(.headline)
                
                // Make the TextField larger and fit the width
                TextField("Enter your Slack Webhook URL", text: $webhookURL)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, minHeight: 40) // Adjust TextField height and stretch width
            }
            .padding(.horizontal) // Padding on the sides for the TextField
            
            // Save Settings button - Center aligned
            Button(action: {
                saveSettings()
                isPresented = false
            }) {
                Text("Save")
                    .frame(maxWidth: .infinity)   // Make the button full width
                    .frame(height: 40)            // Set consistent height
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.horizontal)
            
            // Close button under Save button
            Button(action: {
                isPresented = false
            }) {
                Text("Close")
                    .frame(maxWidth: .infinity)   // Make the button full width
                    .frame(height: 40)            // Set consistent height
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.horizontal)

           
        }
        .frame(minWidth: 400, maxWidth: .infinity, maxHeight: 200) // Make view fill the available width
        .padding(.vertical, 20) // Padding at the top and bottom
        .onAppear {
            loadSettings()
        }
    }
    
    // Load settings from the database
    private func loadSettings() {
        if let appSettings = settings.first {
            webhookURL = appSettings.slackWebhookURL
        } else {
            // Create default settings if not already present
            let defaultSettings = AppSettings(slackWebhookURL: "")
            context.insert(defaultSettings)
        }
    }
    
    // Save the webhook URL to SwiftData
    private func saveSettings() {
        if let appSettings = settings.first {
            appSettings.slackWebhookURL = webhookURL
            try? context.save() // Save changes to SwiftData
        }
    }
}




struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isPresented: .constant(true))  // Binding a constant value for the preview
            .modelContainer(for: AppSettings.self)  // Provide a model container for preview
    }
}

