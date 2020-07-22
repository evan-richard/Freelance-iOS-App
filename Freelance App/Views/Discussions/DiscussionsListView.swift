//
//  DiscussionsListView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/21/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct DiscussionsListView: View {
    @ObservedObject var discussionListVM: DiscussionListViewModel
    @Binding var searchString: String
    
    var body: some View {
        List(discussionListVM.discussionCellViewModels.filter({ discussionCellVM in
            if searchString != "" {
                return discussionCellVM.title.lowercased().contains(searchString.lowercased()) || discussionCellVM.lastMessageAuthor.lowercased().contains(searchString.lowercased()) || discussionCellVM.lastMessageText.lowercased().contains(searchString.lowercased())
            } else {
                return true
            }
        })) { discussionCellVM in
            DiscussionsListCellView(discussionCellVM: discussionCellVM)
        }
    }
}

struct DiscussionsListView_Previews: PreviewProvider {
    static var previews: some View {
        DiscussionsListView(discussionListVM: DiscussionListViewModel(), searchString: Binding.constant(""))
    }
}
