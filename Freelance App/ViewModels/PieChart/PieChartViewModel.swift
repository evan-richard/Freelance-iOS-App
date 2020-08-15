//
//  PieChartViewModel.swift
//  Freelance App
//
//  Created by Evan Richard on 8/13/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import Foundation
import SwiftUI

class PieChartViewModel: ObservableObject {
    @Published var data: [PieChartSliceViewModel] = []
    
    init(data: [PieChartDataModel]) {
        var currentAngle: Double = -90
        var total: Double = 0.0
        data.forEach { dataSet in
            total += dataSet.value
        }
        
        self.data = data.map { dataSet in
            let startAngle: Angle = .degrees(currentAngle)
            let angle = dataSet.value * 360 / total
            currentAngle += angle
            let endAngle: Angle = .degrees(currentAngle)
            
            return PieChartSliceViewModel(
                data: dataSet,
                startAngle: startAngle,
                endAngle: endAngle
            )
        }
    }
    
    init(data: [PieChartSliceViewModel]) {
        self.data = data
    }
}
