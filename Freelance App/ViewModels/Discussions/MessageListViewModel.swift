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

class MessageListViewModel: ObservableObject  {
    @Published var discussionId: String = ""
    @Published var discussionTitle: String = ""
    @Published var messageViewModels: [MessageViewModel] = [MessageViewModel]()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var cancellables = Set<AnyCancellable>()
    
    init(discussionId: String) {
        self.discussionId = discussionId
        self.appDelegate.discussionsStore?.$discussions
            .map { discussions in
                var messages: [MessageViewModel] = [MessageViewModel]()
                if let discussion: Discussion = discussions.first(where: { discussion in
                    discussion.id == discussionId
                }) {
                    self.discussionTitle = discussion.title
                    messages = discussion.messages.map { messages in
                        messages.map { message in
                            MessageViewModel(
                                text: message.text,
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
