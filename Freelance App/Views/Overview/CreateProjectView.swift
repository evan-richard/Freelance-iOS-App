//
//  CreateProjectView.swift
//  Freelance App
//
//  Created by Evan Richard on 8/22/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct CreateProjectView: View {
    @Binding var isOpen: Bool
    @Binding var projectName: String
    @Binding var customerName: String
    
    var confirmAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            VStack(alignment: .leading) {
                Text("Project Title:")
                TextField("Enter project title", text: self.$projectName)
                    .textFieldStyle(ReplyTextFieldStyle())
            }
            
            VStack(alignment: .leading) {
                Text("Customer Name:")
                TextField("Enter customer name", text: self.$customerName)
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
        self.projectName = ""
        self.customerName = ""
    }
    
    private func saveAction() {
        confirmAction()
        withAnimation {
            self.isOpen.toggle()
        }
        self.projectName = ""
        self.customerName = ""
    }
}

struct CreateProjectView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProjectView(isOpen: Binding.constant(true), projectName: Binding.constant(""), customerName: Binding.constant(""), confirmAction: {})
    }
}
