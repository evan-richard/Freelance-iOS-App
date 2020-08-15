//
//  PieChartView.swift
//  Freelance App
//
//  Created by Evan Richard on 8/13/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct PieChartView: View {
    var pieChartVM: PieChartViewModel
    
    var body: some View {
        self.makePieChart(pieChartData: self.pieChartVM.data)
    }
    
    func makePieChart(pieChartData: [PieChartSliceViewModel]) -> some View {
        return ZStack {
            ForEach(0..<pieChartData.count, id: \.self) { index in
                PieChartSliceView(sliceVM: pieChartData[index])
            }
        }
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView(pieChartVM: PieChartViewModel(data: [
            PieChartDataModel(
                name: RequirementStatusConstants.DONE,
                value: 2,
                color: RequirementThemeConstants.STATUS_DONE_COLOR
            ),
            PieChartDataModel(
                name: RequirementStatusConstants.IN_PROGRESS,
                value: 2,
                color: RequirementThemeConstants.STATUS_IN_PROGRESS_COLOR
            ),
            PieChartDataModel(
                name: RequirementStatusConstants.TO_DO,
                value: 2,
                color: RequirementThemeConstants.STATUS_TO_DO_COLOR
            )
        ]))
    }
}
