//
//  DiscussionsStore.swift
//  Freelance App
//
//  Created by Evan Richard on 7/21/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class DiscussionsStore: ObservableObject {
    @Published var discussions: [Discussion] = [Discussion]()
    
    private let db = Firestore.firestore()
    
    init(projectId: String) {
        self.loadDiscussionsList(projectId: projectId)
    }
    
    func populateMessagesForDiscussionWith(id: String) {
        if CoreConstants.USE_FIRESTORE {
            db.collection("discussions").document(id).collection("messages").order(by: "timestamp").addSnapshotListener { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    if let index: Int = self.discussions.firstIndex(where: { discussion in
                        discussion.id == id
                    }) {
                        self.discussions[index].messages = querySnapshot!.documents.compactMap { document -> DiscussionMessage? in
                            try? document.data(as: DiscussionMessage.self)
                        }
                    }
                }
            }
        }
    }
    
    private func loadDiscussionsList(projectId: String) -> Void {
        if CoreConstants.USE_FIRESTORE {
            db.collection("discussions").whereField("projectId", isEqualTo: projectId).order(by: "lastMessageTimestamp", descending: true).addSnapshotListener { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    self.discussions = querySnapshot!.documents.compactMap { document -> Discussion? in
                            try? document.data(as: Discussion.self)
                    }
                }
            }
        } else {
            self.discussions = [
                Discussion(id: "1", projectId: "123", title: "Testing without requirment", lastMessageAuthor: "Developer 1", lastMessageText: "The latest message in the conversation is here, and it is really long. I really want to test the length of the blobs that stores the text so that is why I am typing so much.", lastMessageTimestamp: Timestamp(), messages: [
                    DiscussionMessage(id: "1", author: "Developer 1", authorId: "test1", text: "This is the first message", timestamp: Timestamp()),
                    DiscussionMessage(id: "2", author: "Developer 2", authorId: "test2", text: "Second message", timestamp: Timestamp()),
                    DiscussionMessage(id: "3", author: "Developer 1", authorId: "test2", text: "The latest message in the conversation is here, and it is really long. I really want to test the length of the blobs that stores the text so that is why I am typing so much.", timestamp: Timestamp()),
                    DiscussionMessage(id: "4", author: "Developer 1", authorId: "test1", text: "This is the fourth message", timestamp: Timestamp()),
                    DiscussionMessage(id: "5", author: "Developer 2", authorId: "test2", text: "fifth message", timestamp: Timestamp()),
                    DiscussionMessage(id: "6", author: "Developer 1", authorId: "test2", text: "Sixth message The latest message in the conversation is here, and it is really long. I really want to test the length of the blobs that stores the text so that is why I am typing so much.", timestamp: Timestamp())
                    ]),
                Discussion(id: "2", projectId: "123", title: "[Req] 2.1 Biography", lastMessageAuthor: "Developer 3", lastMessageText: "Test last message two", lastMessageTimestamp: Timestamp(), messages: [
                    DiscussionMessage(id: "1", author: "Developer 1", authorId: "test1", text: "This is the first message", timestamp: Timestamp()),
                    DiscussionMessage(id: "2", author: "Developer 2", authorId: "test2", text: "Second message", timestamp: Timestamp()),
                    DiscussionMessage(id: "3", author: "Developer 3", authorId: "test2", text: "Test last message two", timestamp: Timestamp())
                ], requirementId: "6")
            ]
        }
    }
}
