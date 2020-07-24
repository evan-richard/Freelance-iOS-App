//
//  MessagesHeaderView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/22/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct MessagesHeaderView: View {
    @Binding var isMessagesSheetOpen: Bool
    
    var discussionTitle: String
    
    var body: some View {
        HStack {
            Text(discussionTitle)
                .font(.title)
            Spacer()
            Button(action: self.closeDiscussionAction) {
                Text("Done")
                    .fontWeight(.semibold)
            }
            .accentColor(.purple)
        }
    }
    
    private func closeDiscussionAction() {
        self.isMessagesSheetOpen.toggle()
    }
}

struct MessagesHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesHeaderView(isMessagesSheetOpen: Binding.constant(true), discussionTitle: "[Req] 4.6.3 Contact Information")
    }
}
