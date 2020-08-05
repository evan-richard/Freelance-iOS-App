//
//  ReplyTextFieldView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/23/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct ReplyTextFieldView: View {
    @Binding var reply: String
    
    var sendReply: () -> Void
    
    var body: some View {
        HStack {
            TextField("Enter text to reply", text: $reply)
                .textFieldStyle(ReplyTextFieldStyle())
            Button(action: sendReply) {
                ReusableTextButtonView(label: "Send")
            }
        }
        .padding(.horizontal)
    }
}

struct ReplyTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        ReplyTextFieldView(reply: Binding.constant(""), sendReply: {})
    }
}
