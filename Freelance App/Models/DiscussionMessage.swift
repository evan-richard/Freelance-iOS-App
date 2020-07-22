//
//  DiscussionMessage.swift
//  Freelance App
//
//  Created by Evan Richard on 7/21/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct DiscussionMessage: Identifiable, Codable {
    var id: String
    var author: String
    var authorId: String
    var text: String
    var timestamp: Timestamp
}
