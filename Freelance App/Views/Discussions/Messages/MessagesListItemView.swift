//
//  MessageListItemView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/22/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI
import FirebaseFirestore

struct MessagesListItemView: View {
    @ObservedObject var messageVM: MessageViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(messageVM.text)
            HStack {
                Text(messageVM.timestamp)
                Spacer()
                Text(messageVM.author)
            }
            .foregroundColor(.secondary)
            .font(.system(size: 14))
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(20)
        .contextMenu {
            Button(action: self.copyMessageAction) {
                Text("Copy")
                IconConstants.COPY
            }

            if messageVM.authorId == self.messageVM.userId && !self.messageVM.isDeleted {
                // Only let the author edit/delete messages
                
                Button(action: self.editMessageAction) {
                    Text("Edit")
                    IconConstants.EDIT
                }
                
                Button(action: self.deleteMessageAction) {
                    Text("Delete")
                    IconConstants.DELETE
                }
            }
        }
    }

    private func copyMessageAction() {
        UIPasteboard.general.string = self.messageVM.text
    }
    
    private func editMessageAction() { }
    
    private func deleteMessageAction() {
        self.messageVM.deleteMessage()
    }
}

struct MessagesListItemView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesListItemView(messageVM: MessageViewModel(messageId: "1", text: "Loirem ipsum dolor sit amet, conesctoru apldicisng elit. Sed do esimod tempor incidi ut lavore et dolo magma aliqua. Ut incidicunt ut lavore et dolor, quis mostrud exercitation enem ad minimu.", authorId: "test1", author: "Kim Farland", timestamp: Timestamp()))
    }
}
