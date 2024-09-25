//
//  Project.swift
//  ReleaseRocket
//
//  Created by Voxpopme on 25/09/2024.
//

import Foundation
import SwiftData

@Model
final class Project {
    var id: UUID  // Unique identifier
    var name: String
    var version: String
    var build: String
    var releaseNotes: String
    var platform: String    // New platform field (e.g., iOS, Android, etc.)
    var author: String      // New author field
    var featureType: String // New feature type field (e.g., Bug Fix, Maintenance)
    var notifyOption: String  // New notify option (e.g., @channel, @here, None)

    // Initializer with default values for platform, feature type, and notify option
    init(name: String, version: String, build: String, releaseNotes: String, platform: String = "iOS", author: String = "", featureType: String = "Bug Fix", notifyOption: String = "None") {
        self.id = UUID()  // Automatically generate a unique ID when a project is created
        self.name = name
        self.version = version
        self.build = build
        self.releaseNotes = releaseNotes
        self.platform = platform
        self.author = author
        self.featureType = featureType
        self.notifyOption = notifyOption
    }
}


