//
//  AppSettings.swift
//  ReleaseRocket
//
//  Created by Voxpopme on 25/09/2024.
//

import Foundation
import SwiftData

@Model
final class AppSettings {
    var slackWebhookURL: String

    // Initializer
    init(slackWebhookURL: String) {
        self.slackWebhookURL = slackWebhookURL
    }
}
