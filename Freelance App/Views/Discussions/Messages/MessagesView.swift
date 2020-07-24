//
//  MessagesView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/22/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct MessagesView: View {
    @ObservedObject var messageListVM: MessageListViewModel = MessageListViewModel()
    @State private var reply: String = ""
    @Binding var isMessagesSheetOpen: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 20) {
                MessagesHeaderView(isMessagesSheetOpen: $isMessagesSheetOpen, discussionTitle: messageListVM.discussionTitle)
                    .padding(.horizontal)
                MessagesListView(messageListVM: messageListVM)
            }
            Spacer()
            ReplyTextFieldView(reply: $reply, sendReply: self.sendReply)
        }
        .padding(.vertical)
    }
    
    private func sendReply() {
        self.messageListVM.sendReply(reply: self.reply)
        self.reply = ""
        // TODO: scroll to the bottom of the list when iOS 14 is released
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView(isMessagesSheetOpen: Binding.constant(true))
    }
}
