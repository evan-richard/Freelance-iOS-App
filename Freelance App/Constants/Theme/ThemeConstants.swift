//
//  ThemeConstants.swift
//  Freelance App
//
//  Created by Evan Richard on 8/3/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import Foundation
import SwiftUI

struct ThemeConstants {
    static var ACCENT_COLOR: Color = Color(red: 0/255, green: 116/255, blue: 217/255)
    static var ACCENT_COLOR_BACKGROUND: Color = Color(red: 55/255, green: 93/255, blue: 129/255)
    static var ACCENT_COLOR_FOREGROUND: Color = .white
    static var DANGER_COLOR: Color = Color(red: 190/255, green: 40/255, blue: 5/255)
}

struct RequirementThemeConstants {
    static var PRIMARY_ACCENT_COLOR: Color = Color(red: 255/255, green: 116/255, blue: 77/255)
    static var SECONDARY_ACCENT_COLOR: Color = Color(red: 244/255, green: 91/255, blue: 36/255)
    static var ACCENT_COLOR_FOREGROUND: Color = .white
    static var STATUS_DONE_COLOR: Color = Color(red: 30/255, green: 153/255, blue: 47/255)
    static var STATUS_IN_PROGRESS_COLOR: Color = Color(red: 30/255, green: 57/255, blue: 153/255)
    static var STATUS_TO_DO_COLOR: Color = Color(red: 102/255, green: 87/255, blue: 71/255)
}

struct DiscussionThemeConstants {
    static var PRIMARY_ACCENT_COLOR: Color = Color(red: 47/255, green: 159/255, blue: 255/255)
    static var SECONDARY_ACCENT_COLOR: Color = Color(red: 7/255, green: 130/255, blue: 223/255)
    static var ACCENT_COLOR_FOREGROUND: Color = .white
}

struct TimesheetThemeConstants {
    static var PRIMARY_ACCENT_COLOR: Color = Color(red: 167/255, green: 12/255, blue: 193/255)
    static var SECONDARY_ACCENT_COLOR: Color = Color(red: 107/255, green: 12/255, blue: 121/255)
    static var ACCENT_COLOR_FOREGROUND: Color = .white
}
