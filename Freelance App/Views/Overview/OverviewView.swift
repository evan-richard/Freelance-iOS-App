//
//  OverviewScreen.swift
//  Freelance App
//
//  Created by Evan Richard on 7/3/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct OverviewView: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            ProjectDetailView()
            Spacer()
            NavigationListView()
                .padding(.bottom, 20)
        }
        .navigationBarTitle("Overview", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: self.shareProjectAction) {
            Image(systemName: "square.and.arrow.up")
                .foregroundColor(ThemeConstants.ACCENT_COLOR)
                .imageScale(.large)
        })
        .padding()
    }
    
    private func shareProjectAction() { }
}

struct OverviewView_Previews: PreviewProvider {
    static var previews: some View {
        OverviewView()
    }
}
