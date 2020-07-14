//
//  User.swift
//  Freelance App
//
//  Created by Evan Richard on 7/13/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import Foundation

struct User: Identifiable, Codable {
    var id: String
    var email: String?
    var displayName: String?
    var type: String?
    
}
