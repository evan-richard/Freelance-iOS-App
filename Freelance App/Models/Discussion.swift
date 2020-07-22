//
//  Discussion.swift
//  Freelance App
//
//  Created by Evan Richard on 7/21/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Discussion: Identifiable, Codable {
    var id: String
    var projectId: String
    var title: String
    var lastMessageAuthor: String
    var lastMessageText: String
    var lastMessageTimestamp: Timestamp
    var messages: [DiscussionMessage]?
    var requirementId: String?
}
