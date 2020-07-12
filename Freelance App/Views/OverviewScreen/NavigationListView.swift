//
//  NavigationListView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/12/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct NavigationListView: View {
    
    private let navigationLinks: [String] = [
        "Requirements",
    ]
    
    var body: some View {
        List(navigationLinks, id: \.self) { link in
            NavigationLink(destination: self.getViewFromLink(link: link)) {
                Text(link)
                    .fontWeight(.semibold)
            }
            .padding(.vertical, 8)
        }
    }
    
    private func getViewFromLink(link: String) -> some View {
        switch link {
        case "Requirements":
            return RequirementsScreen()
        default:
            return RequirementsScreen()
        }
    }
}

struct NavigationListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationListView()
    }
}
