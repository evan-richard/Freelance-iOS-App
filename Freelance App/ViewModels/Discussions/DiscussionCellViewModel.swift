//
//  DiscussionListCellViewModel.swift
//  Freelance App
//
//  Created by Evan Richard on 7/21/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import Foundation
import Combine

class DiscussionCellViewModel: ObservableObject, Identifiable  {
    var id: UUID
    @Published var discussionId: String = ""
    @Published var title: String = ""
    @Published var lastMessageAuthor: String = ""
    @Published var lastMessageText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(discussionId: String, title: String, lastMessageAuthor: String, lastMessageText: String) {
        id = UUID()
        self.discussionId = discussionId
        self.title = title
        self.lastMessageAuthor = lastMessageAuthor
        self.lastMessageText = lastMessageText
    }
}