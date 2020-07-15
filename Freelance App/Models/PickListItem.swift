//
//  PickListOption.swift
//  Freelance App
//
//  Created by Evan Richard on 7/15/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import Foundation

struct PickListItem: Identifiable {
    var id = UUID()
    var label: String
    var icon: String?
}
