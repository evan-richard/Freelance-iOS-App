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
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(20)
    }
}

struct MessagesListItemView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesListItemView(messageVM: MessageViewModel(text: "Loirem ipsum dolor sit amet, conesctoru apldicisng elit. Sed do esimod tempor incidi ut lavore et dolo magma aliqua. Ut incidicunt ut lavore et dolor, quis mostrud exercitation enem ad minimu.", author: "Kim Farland", timestamp: Timestamp()))
    }
}
