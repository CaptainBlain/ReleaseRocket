//
//  ReleaseHistory.swift
//  ReleaseRocket
//
//  Created by Voxpopme on 25/09/2024.
//

import Foundation
import SwiftData

@Model
final class ReleaseHistory {
    var projectName: String
    var version: String
    var build: String
    var releaseNotes: String
    var platform: String  // New field for platform (iOS, Android, etc.)
    var author: String    // New field for author
    var featureType: String  // New field for feature type (Bug Fix, Maintenance, etc.)
    var notifyOption: String // New field for notify option (@channel, @here, None)
    var date: Date

    // Initializer
    init(projectName: String, version: String, build: String, releaseNotes: String, platform: String, author: String, featureType: String, notifyOption: String, date: Date = Date()) {
        self.projectName = projectName
        self.version = version
        self.build = build
        self.releaseNotes = releaseNotes
        self.platform = platform
        self.author = author
        self.featureType = featureType
        self.notifyOption = notifyOption
        self.date = date
    }
}

