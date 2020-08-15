//
//  TimesheetGraphBarView.swift
//  Freelance App
//
//  Created by Evan Richard on 8/8/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct TimesheetGraphBarView: View {
    var day: String
    var hours: Int
    var isToday: Bool = false
    var geometryWidth: CGFloat
    
    var body: some View {
        HStack {
            Text(day)
                .fontWeight(isToday ? .bold : .medium)
            Spacer()
            Text(String(describing: hours))
                .fontWeight(isToday ? .bold : .medium)
        }
        .frame(maxWidth: (CGFloat(hours + 1)/10) * geometryWidth, maxHeight: 20)
        .padding(.vertical, 8)
        .padding(.horizontal, 20)
        .foregroundColor(TimesheetThemeConstants.ACCENT_COLOR_FOREGROUND)
        .background(TimesheetThemeConstants.SECONDARY_ACCENT_COLOR)
        .cornerRadius(20)
    }
}

struct TimesheetGraphBarView_Previews: PreviewProvider {
    static var previews: some View {
        TimesheetGraphBarView(day: "M", hours: 3, geometryWidth: .greatestFiniteMagnitude)
    }
}
