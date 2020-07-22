//
//  DiscussionsView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/21/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct DiscussionsView: View {
    @ObservedObject var discussionListVM: DiscussionListViewModel = DiscussionListViewModel()
    @State private var searchString: String = ""
    @State private var isSearching: Bool = false
    @State private var isFilterActive: Bool = false
    @State private var isCreateDiscussionOpen: Bool = false
    
    var body: some View {
        VStack {
            SearchBarView(searchString: $searchString, isSearching: $isSearching)
            DiscussionsListView(discussionListVM: discussionListVM, searchString: $searchString)
            Spacer()
            DiscussionsFooterView(isFilterActive: $isFilterActive, isCreateDiscussionOpen: $isCreateDiscussionOpen, numberOfNewMessages: Binding.constant(0))
        }
        .navigationBarTitle("Discussion", displayMode: .large)
        .padding()
    }
}

struct DiscussionsView_Previews: PreviewProvider {
    static var previews: some View {
        DiscussionsView()
    }
}
