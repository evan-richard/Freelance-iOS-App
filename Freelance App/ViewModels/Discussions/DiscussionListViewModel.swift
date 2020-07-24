//
//  DiscussionListViewModel.swift
//  Freelance App
//
//  Created by Evan Richard on 7/21/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import Foundation
import UIKit
import Combine

class DiscussionListViewModel: ObservableObject {
    @Published var discussionCellViewModels: [DiscussionCellViewModel] = [DiscussionCellViewModel]()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.appDelegate.discussionsStore?.$discussions
            .map { discussions in
                discussions.map { discussion in
                    DiscussionCellViewModel(
                        discussionId: discussion.id,
                        title: discussion.title,
                        lastMessageAuthor: discussion.lastMessageAuthor,
                        lastMessageText: discussion.lastMessageText
                    )
            }
        }
        .assign(to: \.discussionCellViewModels, on: self)
        .store(in: &cancellables)
    }
    
    func populateMessagesForDiscussion() {
        self.appDelegate.discussionsStore?.populateMessagesForDiscussion()
    }
}
