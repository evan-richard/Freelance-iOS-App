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
    @State private var isMessagesSheetOpen: Bool = false
    @State private var selectedDiscussionId: String = ""
    
    var body: some View {
        VStack {
            SearchBarView(searchString: $searchString, isSearching: $isSearching)
            DiscussionsListView(discussionListVM: discussionListVM, searchString: $searchString, isMessagesSheetOpen: $isMessagesSheetOpen, selectedDiscussionId: $selectedDiscussionId, selectAction: self.selectAction)
            Spacer()
            DiscussionsFooterView(isFilterActive: $isFilterActive, isCreateDiscussionOpen: $isCreateDiscussionOpen, numberOfNewMessages: Binding.constant(0))
        }
        .navigationBarTitle("Discussion", displayMode: .large)
        .padding()
        .sheet(isPresented: $isMessagesSheetOpen) {
            MessagesView(discussionId: self.selectedDiscussionId, isMessagesSheetOpen: self.$isMessagesSheetOpen)
        }
    }
    
    private func selectAction() -> Void {
        self.discussionListVM
            .populateMessagesForDiscussionWith(id: self.selectedDiscussionId)
    }
}

struct DiscussionsView_Previews: PreviewProvider {
    static var previews: some View {
        DiscussionsView()
    }
}
