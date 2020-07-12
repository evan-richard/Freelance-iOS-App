//
//  OverviewScreen.swift
//  Freelance App
//
//  Created by Evan Richard on 7/3/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct OverviewScreen: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            ProjectDetailView()
            NavigationListView()
        }
        .navigationBarTitle("Overview", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
//            pass
        }) {
            Image(systemName: "square.and.arrow.up")
                .foregroundColor(.purple)
                .imageScale(.large)
        })
        .padding()
    }
}

struct OverviewScreen_Previews: PreviewProvider {
    static var previews: some View {
        OverviewScreen()
    }
}
