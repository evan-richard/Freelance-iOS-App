//
//  CreateProjectView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/3/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct CreateProjectView: View {
    @Binding var projectName: String
    @Binding var customerName: String
    @Binding var isOpen: Bool
    
    var confirmAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            VStack(alignment: .leading, spacing: 20) {
                FormTextFieldView(value: $projectName, label: "Project Title:", placeholder: "Enter project title")
                FormTextFieldView(value: $customerName, label: "Customer Name:", placeholder: "Enter customer name")
            }
            
            HStack() {
                LargeTextButtonView(label: "Cancel", action: self.cancelAction, isPrimary: false)
                Spacer()
                LargeTextButtonView(label: "Create", action: self.createAction, isPrimary: true)
            }
        }
    }
    
    private func cancelAction() {
        self.hideKeyboard()
        self.projectName = ""
        self.customerName = ""
        withAnimation {
            self.isOpen.toggle()
        }
    }
    
    private func createAction() {
        confirmAction()
        self.projectName = ""
        self.customerName = ""
        self.hideKeyboard()
        withAnimation {
            self.isOpen.toggle()
        }
    }
}

struct CreateProjectView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProjectView(projectName: Binding.constant(""), customerName: Binding.constant(""), isOpen: Binding.constant(true), confirmAction: {})
    }
}
