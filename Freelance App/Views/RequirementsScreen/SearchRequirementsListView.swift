//
//  SearchRequirementsListView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/9/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct SearchRequirementsListView: View {
    @Binding var searchString: String
    @Binding var isSearching: Bool
    
    var body: some View {
        VStack {
            SearchBar(searchString: $searchString, isSearching: $isSearching)
            RequirementsList(searchString: $searchString)
            Spacer()
        }
    }
}

struct SearchRequirementsListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchRequirementsListView(searchString: Binding.constant(""), isSearching: Binding.constant(false))
    }
}
