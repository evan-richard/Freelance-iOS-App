//
//  Project.swift
//  Freelance App
//
//  Created by Evan Richard on 7/3/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//
import Foundation

struct Project: Identifiable, Codable {
    var id: String
    var userId: String
    var appName: String
    var customerName: String
    var description: String?
    var topLevelReqs: [String]?
}
