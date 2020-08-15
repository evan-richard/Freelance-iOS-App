//
//  PieChartDataModel.swift
//  Freelance App
//
//  Created by Evan Richard on 8/13/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import Foundation
import SwiftUI

class PieChartDataModel {
    var name: String
    var value: Double
    var color: Color
    
    init(name: String, value: Double, color: Color) {
        self.name = name
        self.value = value
        self.color = color
    }
}
