//
//  AppViewModel.swift
//  ReleaseRocket
//
//  Created by Voxpopme on 25/09/2024.
//

import SwiftData
import Foundation

class AppViewModel: ObservableObject {
    
    // Function to send release notes to Slack
    func sendReleaseNotes(for project: Project, webhookURL: String, completion: @escaping (Bool) -> Void) {
        // Ensure the webhook URL is valid
        guard let url = URL(string: webhookURL) else {
            print("Error: Invalid webhook URL")
            completion(false)
            return
        }

        // Determine the notify option string
        let notifyString = project.notifyOption != "None" ? "\(project.notifyOption) " : ""

        // Platform-specific message
        let platformMessage: String
        switch project.platform {
        case "iOS":
            platformMessage = "*A new build has been sent to the App Store*"
        case "Android":
            platformMessage = "*A new build has been sent to the Play Store*"
        case "Web", "Backend":
            platformMessage = "*A new build has been released*"
        default:
            platformMessage = "*A new build has been released*"
        }

        // Create the payload
        let payload: [String: Any] = [
            "text": """
            \(notifyString)Release Notes for *\(project.name)*
            \(platformMessage)

            *\(project.author)*

            *Release Type:* 
            \(project.featureType)

            *Notes:*
            \(project.releaseNotes)

            *Project*
            \(project.name) \(project.platform) 
            \(project.version) \(project.build)

            """
        ]

        // Convert the payload to JSON data
        guard let jsonData = try? JSONSerialization.data(withJSONObject: payload, options: []) else {
            print("Error: Cannot create JSON payload")
            completion(false)
            return
        }

        // Create a URLRequest object
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        // Send the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Failed to send release notes: \(error.localizedDescription)")
                completion(false)
                return
            }

            // Handle the response status
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("Release notes sent successfully!")
                completion(true)
            } else {
                print("Failed to send release notes. HTTP Status Code: \(String(describing: response))")
                completion(false)
            }
        }

        task.resume()
    }
}



