//
//  MessageListView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/22/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct MessagesListView: View {
    @ObservedObject var messageListVM: MessageListViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(messageListVM.messageViewModels) { messageVM in
                        MessagesListItemView(messageVM: messageVM)
                    }
                }
                .padding(.horizontal)
            }
            .onAppear {
                // TODO: scroll to the bottom of the list when iOS 14 is released
            }
        }
    }
}

struct MessagesListView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesListView(messageListVM: MessageListViewModel())
    }
}
