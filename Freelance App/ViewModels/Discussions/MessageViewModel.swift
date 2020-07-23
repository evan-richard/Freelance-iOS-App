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
    @Published var text: String = ""
    @Published var author: String = ""
    @Published var timestamp: String = ""
    
    private let df = DateFormatter()
    private var cancellables = Set<AnyCancellable>()
    
    init(text: String, author: String, timestamp: Timestamp) {
        id = UUID()
        self.text = text
        self.author = author
        df.dateFormat = "MMM dd, yyyy h:mm a"
        self.timestamp = df.string(from: timestamp.dateValue())
    }
}
