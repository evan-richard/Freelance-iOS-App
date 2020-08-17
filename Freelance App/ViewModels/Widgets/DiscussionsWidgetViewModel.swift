//
//  DiscussionsWidgetViewModel.swift
//  Freelance App
//
//  Created by Evan Richard on 8/9/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import Foundation
import Combine
import UIKit

class DiscussionsWidgetViewModel: ObservableObject {
    @Published var lastMessageText: String = ""
    @Published var lastMessageAuthor: String = ""
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.appDelegate.discussionsStore.$discussions.sink { discussions in
            self.lastMessageText = ""
            self.lastMessageAuthor = ""
            
            if discussions.count > 0 {
                self.lastMessageText = discussions[0].lastMessageText
                self.lastMessageAuthor = discussions[0].lastMessageAuthor
            }
        }
        .store(in: &self.cancellables)
    }
}
