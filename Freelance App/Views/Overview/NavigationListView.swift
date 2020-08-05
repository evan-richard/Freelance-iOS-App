//
//  NavigationListView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/12/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct NavigationListView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(OverviewNavLinkConstants.NAVIGATION_LINKS, id: \.self) { link in
                NavigationListItemView(label: link)
            }
            Divider()
        }
    }
}

struct NavigationListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationListView()
    }
}
