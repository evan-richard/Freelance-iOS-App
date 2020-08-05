//
//  EmptyRequirmentListView.swift
//  Freelance App
//
//  Created by Evan Richard on 8/2/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct EmptyRequirmentListView: View {
    @Binding var isPopupViewOpen: Bool
    @Binding var contextMenuAction: String
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(spacing: 10) {
                Text("Oops!")
                    .font(.headline)
                Text("You haven't created any requirements yet.")
            }
            LargeTextButtonView(label: "Create One", action: self.openDeletePopupAction, isPrimary: true)
        }
    }
    
    private func openDeletePopupAction() {
        self.contextMenuAction = "Create"
        self.isPopupViewOpen.toggle()
    }
}

struct EmptyRequirmentListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyRequirmentListView(isPopupViewOpen: Binding.constant(false), contextMenuAction: Binding.constant(""))
    }
}
