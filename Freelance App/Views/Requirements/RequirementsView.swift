//
//  RequirementsScreen.swift
//  Freelance App
//
//  Created by Evan Richard on 7/3/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct RequirementsView: View {
    @State private var isSearching: Bool = false
    @State private var searchString: String = ""
    @State private var isRequirementDetailOpen: Bool = false
    
    var body: some View {
        VStack {
            if isSearching {
                SearchBarView(searchString: $searchString, isSearching: $isSearching)
                    .navigationBarTitle("Requirements", displayMode: .inline)
            }
            RequirementsListView(searchString: $searchString, isRequirementDetailOpen: $isRequirementDetailOpen)
        }
        .navigationBarTitle("Requirements", displayMode: .large)
        .navigationBarItems(trailing:
            HStack(spacing: 35) {
                Button(action: self.searchAction) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.purple)
                        .imageScale(.large)
                }
            }
        )
        .padding()
        .sheet(isPresented: self.$isRequirementDetailOpen, content: {
            RequirementDetailView(isRequirementDetailViewOpen: self.$isRequirementDetailOpen)
        })
    }
    
    private func searchAction() {
        withAnimation {
            self.isSearching.toggle()
            self.searchString = ""
        }
    }
}

struct RequirementsView_Previews: PreviewProvider {
    static var previews: some View {
        RequirementsView()
    }
}
