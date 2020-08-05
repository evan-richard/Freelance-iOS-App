//
//  RequirementDetailFooterView.swift
//  Freelance App
//
//  Created by Evan Richard on 8/4/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct RequirementDetailFooterView: View {
    @ObservedObject var messageListVM: MessageListViewModel
    @State private var isCommenting: Bool = false
    @State private var reply: String = ""
    
    var body: some View {
        HStack {
            if isCommenting {
                VStack(alignment: .center, spacing: 20) {
                    HStack {
                        TextField("Send a reply", text: $reply)
                            .textFieldStyle(ReplyTextFieldStyle())
                        Button(action: self.toggleCommentMode) {
                            Text("Cancel")
                        }
                        .accentColor(ThemeConstants.ACCENT_COLOR)
                    }
                    Button(action: self.sendReply) {
                        Text("Send")
                            .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: 40)
                            .background(ThemeConstants.ACCENT_COLOR_BACKGROUND)
                        .cornerRadius(35)
                    }
                    .accentColor(ThemeConstants.ACCENT_COLOR_FOREGROUND)
                }
            } else {
                Button(action: self.toggleCommentMode) {
                    Text("Comment")
                        .frame(width: 260, height: 45)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.secondary)
                        )
                }
                Spacer()
                Button(action: {}) {
                    IconConstants.DELETE
                        .frame(width: 45, height: 45)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.secondary)
                        )
                }
            }
        }
        .padding(.horizontal)
    }
    
    private func toggleCommentMode() {
        self.reply = ""
        withAnimation {
            self.isCommenting.toggle()
        }
    }
    
    private func sendReply() {
        self.messageListVM.sendReply(reply: self.reply)
        self.reply = ""
        withAnimation {
            self.isCommenting.toggle()
        }
    }
}

struct RequirementDetailFooterView_Previews: PreviewProvider {
    static var previews: some View {
        RequirementDetailFooterView(messageListVM: MessageListViewModel())
    }
}
