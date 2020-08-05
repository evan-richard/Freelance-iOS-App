//
//  CommentsView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/27/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct CommentsView: View {
    @ObservedObject var requirementDetailVM: RequirementDetailViewModel
    @ObservedObject var messageListVM: MessageListViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            RequirementSectionView(isEditOpen: Binding.constant(false), sectionTitle: "Comments", isEditable: false)
                .padding(.horizontal)
            MessagesListView(messageListVM: messageListVM)
        }
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView(requirementDetailVM: RequirementDetailViewModel(), messageListVM: MessageListViewModel())
    }
}
