//
//  MessagesView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/22/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

public struct ReplyTextFieldStyle : TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .strokeBorder(Color.secondary.opacity(0.5), lineWidth: 1))
    }
}

struct MessagesView: View {
    @ObservedObject var messageListVM: MessageListViewModel
    @State private var reply: String = ""
    @Binding var isMessagesSheetOpen: Bool
    
    init(discussionId: String, isMessagesSheetOpen: Binding<Bool>) {
        self.messageListVM = MessageListViewModel(discussionId: discussionId)
        self._isMessagesSheetOpen = isMessagesSheetOpen
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 20) {
                MessagesHeaderView(isMessagesSheetOpen: $isMessagesSheetOpen, discussionTitle: messageListVM.discussionTitle)
                    .padding(.horizontal)
                MessagesListView(messageListVM: messageListVM)
            }
            Spacer()
            TextField("Enter text to reply", text: $reply)
                .textFieldStyle(ReplyTextFieldStyle())
                .padding(.horizontal)
        }
        .padding(.vertical)
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView(discussionId: "1", isMessagesSheetOpen: Binding.constant(true))
    }
}
