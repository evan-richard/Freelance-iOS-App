//
//  RequirementsWidgetView.swift
//  Freelance App
//
//  Created by Evan Richard on 8/8/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct RequirementsWidgetView: View {
    @ObservedObject var requirementsWidgetVM: RequirementsWidgetViewModel = RequirementsWidgetViewModel()
    
    var body: some View {
        NavigationLink(destination: RequirementsView()) {
            VStack(alignment: .leading, spacing: 10) {
                Text(OverviewNavLinkConstants.REQUIREMENTS)
                    .font(.title)
                HStack(alignment: .center, spacing: 0) {
                    if requirementsWidgetVM.totalNum > 0 {
                        PieChartView(pieChartVM: PieChartViewModel(data: [
                            PieChartDataModel(
                                name: RequirementStatusConstants.DONE,
                                value: Double(requirementsWidgetVM.numOfDone),
                                color: RequirementThemeConstants.STATUS_DONE_COLOR
                            ),
                            PieChartDataModel(
                                name: RequirementStatusConstants.IN_PROGRESS,
                                value: Double(requirementsWidgetVM.numOfInProgress),
                                color: RequirementThemeConstants.STATUS_IN_PROGRESS_COLOR
                            ),
                            PieChartDataModel(
                                name: RequirementStatusConstants.TO_DO,
                                value: Double(requirementsWidgetVM.numOfToDo),
                                color: RequirementThemeConstants.STATUS_TO_DO_COLOR
                            )
                        ]))
                            .padding(.leading, 20)
                            .padding(.top, 8)
                        VStack(alignment: .leading, spacing: 10) {
                            Text("\(requirementsWidgetVM.numOfDone) \(RequirementStatusConstants.DONE)")
                            Text("\(requirementsWidgetVM.numOfInProgress) \(RequirementStatusConstants.IN_PROGRESS)")
                            Text("\(requirementsWidgetVM.numOfToDo) \(RequirementStatusConstants.TO_DO)")
                        }
                        .padding()
                        .padding(.horizontal, 10)
                        .background(
                            RequirementThemeConstants.SECONDARY_ACCENT_COLOR
                        )
                        .cornerRadius(20)
                    }
                }
                .frame(maxWidth: .greatestFiniteMagnitude)
            }
            .padding()
            .foregroundColor(RequirementThemeConstants.ACCENT_COLOR_FOREGROUND)
            .background(
                RadialGradientStyle(accentColor: RequirementThemeConstants.PRIMARY_ACCENT_COLOR)
            )
            .cornerRadius(20)
        }
    }
}

struct RequirementsWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        RequirementsWidgetView()
    }
}
