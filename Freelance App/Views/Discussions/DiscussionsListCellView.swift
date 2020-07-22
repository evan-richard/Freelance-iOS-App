//
//  DiscussionsListCellView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/21/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI
import FirebaseFirestore

struct DiscussionsListCellView: View {
    @ObservedObject var discussionCellVM: DiscussionCellViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(discussionCellVM.title).fontWeight(.semibold)
                    .lineLimit(1)
                Text("\(discussionCellVM.lastMessageAuthor): \(discussionCellVM.lastMessageText)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            .padding(.vertical, 8)
            Spacer()
        }
    }
}

struct DiscussionsListCellView_Previews: PreviewProvider {
    static var previews: some View {
        DiscussionsListCellView(discussionCellVM: DiscussionCellViewModel(title: "Map Zoom Capabilities", lastMessageAuthor: "Donna Torelli", lastMessageText: "We can show the entire portion if you would like but I don't think it is necessary.")
        )
    }
}
