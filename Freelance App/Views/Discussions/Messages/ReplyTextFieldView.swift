//
//  ReplyTextFieldView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/23/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

public struct ReplyTextFieldStyle : TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .strokeBorder(Color.secondary.opacity(0.5), lineWidth: 1))
    }
}

struct ReplyTextFieldView: View {
    @Binding var reply: String
    
    var sendReply: () -> Void
    
    var body: some View {
        HStack {
            TextField("Enter text to reply", text: $reply)
                .textFieldStyle(ReplyTextFieldStyle())
            Button(action: sendReply) {
                ReusableTextButtonView(label: "Reply")
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
