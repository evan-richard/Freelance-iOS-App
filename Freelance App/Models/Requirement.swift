//
//  Requirement.swift
//  Freelance App
//
//  Created by Evan Richard on 7/4/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import Foundation

struct Requirement: Identifiable, Codable {
    var id: String
    var projectId: String
    var title: String
    var status: String
    var assignee: String?
    var assigneeId: String?
    var childReqIds: [String]?
}
