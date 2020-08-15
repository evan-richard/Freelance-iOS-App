//
//  PieChartSliceViewModel.swift
//  Freelance App
//
//  Created by Evan Richard on 8/13/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import Foundation
import SwiftUI

class PieChartSliceViewModel: Identifiable, ObservableObject {
    let id: UUID = UUID()
    var data: PieChartDataModel
    var startAngle: Angle
    var endAngle: Angle
    
    init(data: PieChartDataModel, startAngle: Angle, endAngle: Angle) {
        self.data = data
        self.startAngle = startAngle
        self.endAngle = endAngle
    }
}
