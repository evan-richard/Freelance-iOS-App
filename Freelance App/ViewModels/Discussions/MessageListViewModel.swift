//
//  MessageListViewModel.swift
//  Freelance App
//
//  Created by Evan Richard on 7/22/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import Foundation
import UIKit
import Combine
import FirebaseFirestore

class MessageListViewModel: ObservableObject  {
    @Published var discussionId: String = ""
    @Published var discussionTitle: String = ""
    @Published var messageViewModels: [MessageViewModel] = [MessageViewModel]()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        if let selectedDiscussionId: String = self.appDelegate.discussionsStore.selectedDiscussion?.id {
            self.discussionId = selectedDiscussionId
            self.populateMessages()
        }
    }
    
    func sendReply(reply: String) {
        if let author: User = self.appDelegate.sessionStore.session {
            let message: DiscussionMessage = DiscussionMessage(
                id: String.init(describing: UUID()),
                author: author.displayName ?? "",
                authorId: author.id,
                text: reply,
                timestamp: Timestamp()
            )
            self.appDelegate.discussionsStore.sendReply(message: message)
            self.messageViewModels.append(
                MessageViewModel(messageId: message.id, text: message.text, authorId: message.authorId, author: message.author, timestamp: message.timestamp)
            )
        }
    }
    
    private func populateMessages() {
        self.appDelegate.discussionsStore.$discussions
            .map { discussions in
                var messages: [MessageViewModel] = [MessageViewModel]()
                if let discussion: Discussion = discussions.first(where: { discussion in
                    discussion.id == self.discussionId
                }) {
                    self.discussionTitle = discussion.title
                    messages = discussion.messages.map { messages in
                        messages.map { message in
                            MessageViewModel(
                                messageId: message.id,
                                text: message.text,
                                authorId: message.authorId,
                                author: message.author,
                                timestamp: message.timestamp
                            )
                        }
                    } ?? [MessageViewModel]()
                }
                return messages
            }
        .assign(to: \.messageViewModels, on: self)
        .store(in: &cancellables)
    }
}
