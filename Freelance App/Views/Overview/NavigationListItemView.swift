//
//  NavigationListItemView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/19/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct NavigationListItemView: View {
    var label: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Divider()
            NavigationLink(destination: self.getViewFromLink()) {
                HStack {
                    self.getIconFromLink()
                        .frame(width: 35)
                        .foregroundColor(ThemeConstants.ACCENT_COLOR)
                    Text(label)
                        .fontWeight(.semibold)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .accentColor(.primary)
        }
    }
    
    private func getIconFromLink() -> Image {
        switch self.label {
            case OverviewNavLinkConstants.REQUIREMENTS:
                return OverviewLinkIconConstants.REQUIREMENTS
            case OverviewNavLinkConstants.DISCUSSION:
                return OverviewLinkIconConstants.DISCUSSION
            case OverviewNavLinkConstants.DESIGNS:
                return OverviewLinkIconConstants.DESIGNS
            case OverviewNavLinkConstants.DOCUMENTS:
                return OverviewLinkIconConstants.DOCUMENTS
            case OverviewNavLinkConstants.MILESTONES:
                return OverviewLinkIconConstants.MILESTONES
            case OverviewNavLinkConstants.TIMESHEET:
                return OverviewLinkIconConstants.TIMESHEET
            default:
                return IconConstants.UNAVAILABLE
        }
    }
    
    private func getViewFromLink() -> some View {
        switch self.label {
            case OverviewNavLinkConstants.REQUIREMENTS:
                return AnyView(RequirementsView())
            case OverviewNavLinkConstants.DISCUSSION:
                return AnyView(DiscussionsView())
            default:
                return AnyView(WorkInProgressView())
        }
    }
}

struct NavigationListItemView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationListItemView(label: "Requirements")
    }
}
