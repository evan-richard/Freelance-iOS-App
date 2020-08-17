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
    @Published var selectedDiscussion: Discussion? = nil
    
    private let db = Firestore.firestore()
    private var discussionsSnapshotListener: ListenerRegistration? = nil
    private var messagesSnapshotListener: ListenerRegistration? = nil
    
    func populateMessagesForDiscussion() {
        if self.messagesSnapshotListener != nil {
            self.messagesSnapshotListener?.remove()
        }
        
        if CoreConstants.USE_FIRESTORE {
            if let id: String = selectedDiscussion?.id {
                self.messagesSnapshotListener = db.collection("discussions").document(id).collection("messages").order(by: "timestamp").addSnapshotListener { (querySnapshot, err) in
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
    }
    
    func sendReply(message: DiscussionMessage) {
        if let discussionId = self.selectedDiscussion?.id {
            if CoreConstants.USE_FIRESTORE {
                let ref: DocumentReference = db.collection("discussions").document(discussionId).collection("messages").document()
                ref.setData([
                    "id": ref.documentID,
                    "author": message.author,
                    "authorId": message.authorId,
                    "text": message.text,
                    "timestamp": message.timestamp
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        self.db.collection("discussions").document(discussionId).updateData([
                            "lastMessageAuthor": message.author,
                            "lastMessageText": message.text,
                            "lastMessageTimestamp": message.timestamp
                        ]) { err in
                            if let err = err {
                                print("Error updating document: \(err)")
                            }
                        }
                    }
                }
            } else {
                if let idx = self.discussions.firstIndex(where: { discussion in
                    discussion.id == discussionId
                }) {
                    self.discussions[idx].messages?.append(message)
                    self.discussions[idx].lastMessageAuthor = message.author
                    self.discussions[idx].lastMessageText = message.text
                    self.discussions[idx].lastMessageTimestamp = message.timestamp
                    self.discussions = self.discussions
                        .sorted { discussionOne, discussionTwo in
                            discussionOne.lastMessageTimestamp.compare(discussionTwo.lastMessageTimestamp).rawValue > 0
                        }
                }
            }
        }
    }
    
    func deleteMessage(messageId: String) {
        if let discussionId = self.selectedDiscussion?.id {
            if CoreConstants.USE_FIRESTORE {
                db.collection("discussions").document(discussionId).collection("messages").document(messageId)
                    .updateData([
                    "author": "Anonymous",
                    "isDeleted": true,
                    "text": "<Deleted>"
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        if self.selectedDiscussion!.messages != nil && self.selectedDiscussion!.messages![self.selectedDiscussion!.messages!.count - 1].id == messageId {
                            // If the message being deleted is the latest message,
                            // update the discussion fields
                            self.db.collection("discussions").document(discussionId).updateData([
                                "lastMessageAuthor": "Anonymous",
                                "lastMessageText": "<Deleted>"
                            ]) { err in
                                if let err = err {
                                    print("Error updating document: \(err)")
                                }
                            }
                        }
                    }
                }
            } else {
                if let idx = self.discussions.firstIndex(where: { discussion in
                    discussion.id == discussionId
                }) {
                    if let messageIdx = self.discussions[idx].messages?.firstIndex(where: { m in
                        m.id == messageId
                    }) {
                        self.discussions[idx].messages![messageIdx].author = "Anonymous"
                        self.discussions[idx].messages![messageIdx].isDeleted = true
                        self.discussions[idx].messages![messageIdx].text = "<Deleted>"
                        if messageIdx == self.discussions[idx].messages!.count - 1 {
                            // If the message being deleted is the latest message,
                            // update the discussion fields
                            self.discussions[idx].lastMessageAuthor = "Anonymous"
                            self.discussions[idx].lastMessageText = "<Deleted>"
                        }
                    }
                }
            }
        }
    }
    
    func loadDiscussionsList(projectId: String) -> Void {
        if self.discussionsSnapshotListener != nil {
            self.discussionsSnapshotListener?.remove()
        }
        
        if CoreConstants.USE_FIRESTORE {
            self.discussionsSnapshotListener = db.collection("discussions").whereField("projectId", isEqualTo: projectId).order(by: "lastMessageTimestamp", descending: true).addSnapshotListener { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    self.discussions = querySnapshot!.documents.compactMap { document -> Discussion? in
                        var discussion: Discussion? = try? document.data(as: Discussion.self)
                        if (!self.discussions.isEmpty) {
                            if let currentDiscussion = self.discussions.first(where: { d in
                                d.id == discussion?.id
                            }) {
                                discussion?.messages = currentDiscussion.messages
                            }
                        }
                        return discussion
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
            .sorted { discussionOne, discussionTwo in
                discussionOne.lastMessageTimestamp.compare(discussionTwo.lastMessageTimestamp).rawValue > 0
            }
        }
    }
}
