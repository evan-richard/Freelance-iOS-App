//
//  DiscussionsWidgetView.swift
//  Freelance App
//
//  Created by Evan Richard on 8/8/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct DiscussionsWidgetView: View {
    @ObservedObject var discussionsWidgetVM: DiscussionsWidgetViewModel = DiscussionsWidgetViewModel()
    
    var body: some View {
        NavigationLink(destination: DiscussionsView()) {
            VStack(alignment: .leading, spacing: 10) {
                Text(OverviewNavLinkConstants.DISCUSSION)
                    .font(.title)
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        if discussionsWidgetVM.lastMessageAuthor != "" {
                            Text("\(discussionsWidgetVM.lastMessageAuthor) says")
                                .italic()
                            Text(discussionsWidgetVM.lastMessageText)
                        }
                    }
                    Spacer()
                }
                .frame(maxWidth: .greatestFiniteMagnitude)
                .padding()
                .background(
                    DiscussionThemeConstants.SECONDARY_ACCENT_COLOR
                )
                .cornerRadius(20)
                .shadow(radius: 2)
            }
            .padding()
            .foregroundColor(DiscussionThemeConstants.ACCENT_COLOR_FOREGROUND)
            .background(
                RadialGradientStyle(accentColor: DiscussionThemeConstants.PRIMARY_ACCENT_COLOR)
            )
            .cornerRadius(20)
        }
    }
}

struct DiscussionsWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        DiscussionsWidgetView()
    }
}
