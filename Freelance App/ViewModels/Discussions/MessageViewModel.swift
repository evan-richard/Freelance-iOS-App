//
//  MessageViewModel.swift
//  Freelance App
//
//  Created by Evan Richard on 7/22/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import Foundation
import Combine
import FirebaseFirestore

class MessageViewModel: ObservableObject, Identifiable {
    var id: UUID
    @Published var userId: String = ""
    @Published var messageId: String = ""
    @Published var text: String = ""
    @Published var authorId: String = ""
    @Published var author: String = ""
    @Published var timestamp: String = ""
    @Published var isDeleted: Bool = false
    
    private let df = DateFormatter()
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var cancellables = Set<AnyCancellable>()
    
    init(messageId: String, text: String, authorId: String, author: String, timestamp: Timestamp) {
        id = UUID()
        self.userId = self.appDelegate.sessionStore.session?.id ?? ""
        self.messageId = messageId
        self.text = text
        self.authorId = authorId
        self.author = author
        df.dateFormat = "MMM dd, yyyy h:mm a"
        self.timestamp = df.string(from: timestamp.dateValue())
    }
    
    func deleteMessage() {
        self.appDelegate.discussionsStore.deleteMessage(messageId: self.messageId)
        self.text = "<Deleted>"
        self.author = "Anonymous"
        self.isDeleted = true
    }
}
