//
//  RenameConfirmationView.swift
//  Freelance App
//
//  Created by Evan Richard on 8/3/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct TitleConfirmationView: View {
    @Binding var isOpen: Bool
    @Binding var text: String
    
    var placeholder: String
    var label: String
    var confirmAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            VStack(alignment: .leading) {
                Text(self.label)
                TextField(self.placeholder, text: self.$text)
                    .textFieldStyle(ReplyTextFieldStyle())
            }
            
            HStack() {
                LargeTextButtonView(label: "Cancel", action: self.cancelAction, isPrimary: false)
                Spacer()
                LargeTextButtonView(label: "Confirm", action: self.saveAction, isPrimary: true)
            }
        }
    }
    
    private func cancelAction() {
        self.hideKeyboard()
        withAnimation {
            self.isOpen.toggle()
        }
        self.text = ""
    }
    
    private func saveAction() {
        confirmAction()
        withAnimation {
            self.isOpen.toggle()
        }
        self.text = ""
    }
}

struct TitleConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        TitleConfirmationView(isOpen: Binding.constant(true), text: Binding.constant(""), placeholder: "Enter text here", label: "Requirement Title:", confirmAction: {})
    }
}
