//
//  OverviewNavigationItem.swift
//  Freelance App
//
//  Created by Evan Richard on 7/4/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import Foundation

struct OverviewNavigationItem: Identifiable {
    var id = UUID()
    var name: String
    var view: RequirementsScreen
}
