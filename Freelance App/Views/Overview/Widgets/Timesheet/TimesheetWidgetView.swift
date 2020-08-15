//
//  TimesheetWidgetView.swift
//  Freelance App
//
//  Created by Evan Richard on 8/8/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct TimesheetWidgetView: View {
    var body: some View {
        NavigationLink(destination: WorkInProgressView()) {
            VStack(alignment: .leading, spacing: 10) {
                Text(OverviewNavLinkConstants.TIMESHEET)
                    .font(.title)
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        TimesheetGraphBarView(day: "M", hours: 3, geometryWidth: CGFloat(400))
                        TimesheetGraphBarView(day: "Tu", hours: 8, isToday: true, geometryWidth: CGFloat(400))
                        TimesheetGraphBarView(day: "W", hours: 0, geometryWidth: CGFloat(400))
                    }
                    Spacer()
                }
            }
            .padding()
            .foregroundColor(TimesheetThemeConstants.ACCENT_COLOR_FOREGROUND)
            .background(RadialGradientStyle(accentColor: TimesheetThemeConstants.PRIMARY_ACCENT_COLOR)
            )
            .cornerRadius(20)
        }
    }
}

struct TimesheetWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        TimesheetWidgetView()
    }
}
