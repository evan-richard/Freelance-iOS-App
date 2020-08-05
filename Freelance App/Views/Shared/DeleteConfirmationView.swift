//
//  DeleteConfirmationView.swift
//  Freelance App
//
//  Created by Evan Richard on 8/2/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct DeleteConfirmationView: View {
    @Binding var isOpen: Bool
    
    var label: String
    var warningLabel: String
    var confirmAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            VStack(alignment: .leading, spacing: 10) {
                Text(self.label)
                Text(self.warningLabel)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            HStack() {
                LargeTextButtonView(label: "Cancel", action: self.cancelAction, isPrimary: false)
                Spacer()
                LargeTextButtonView(label: "Delete", action: self.saveAction, isPrimary: true, primaryColor: ThemeConstants.DANGER_COLOR)
            }
        }
    }
    
    private func cancelAction() {
        withAnimation {
            self.isOpen.toggle()
        }
    }
    
    private func saveAction() {
        confirmAction()
        withAnimation {
            self.isOpen.toggle()
        }
    }
}

struct DeleteConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteConfirmationView(isOpen: Binding.constant(true), label: "Are you sure you wish to delete this requirement?", warningLabel: "Note deleting a requirement will also delete any of its subrequirements.", confirmAction: {})
    }
}
