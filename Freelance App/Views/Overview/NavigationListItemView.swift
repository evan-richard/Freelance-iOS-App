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
            NavigationLink(destination: self.getViewFromLink(link: label)) {
                Text(label)
                    .fontWeight(.semibold)
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .accentColor(.primary)
        }
    }
    
    private func getViewFromLink(link: String) -> some View {
        switch link {
            case "Requirements":
                return AnyView(RequirementsView())
            case "Discussion":
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
