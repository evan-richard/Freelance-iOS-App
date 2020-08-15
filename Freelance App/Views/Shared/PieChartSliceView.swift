//
//  PieChartSliceView.swift
//  Freelance App
//
//  Created by Evan Richard on 8/13/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct PieChartSliceView: View {
    var sliceVM: PieChartSliceViewModel
    
    var path: Path {
        let chartSize: CGFloat = PieChartConstants.DIAMETER
        let radius: CGFloat = chartSize / 2.0
        let centerX: CGFloat = radius
        let centerY: CGFloat = radius
        
        var path = Path()
        path.move(to: CGPoint(x: centerX, y: centerY))
        path.addArc(center: CGPoint(x: centerX, y: centerY),
                    radius: radius,
                    startAngle: sliceVM.startAngle,
                    endAngle: sliceVM.endAngle,
                    clockwise: false)
        return path
    }
    
    public var body: some View {
        path.fill(sliceVM.data.color)
            .overlay(path.stroke(Color.white, lineWidth: 1))
    }
}

struct PieChartSliceView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartSliceView(
            sliceVM: PieChartSliceViewModel(
                data: PieChartDataModel(
                    name: RequirementStatusConstants.DONE,
                    value: 2,
                    color: RequirementThemeConstants.STATUS_DONE_COLOR
                ),
                startAngle: .degrees(-70),
                endAngle: .degrees(30)
            )
        )
    }
}
