//
//  RequirementDetailSectionView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/12/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct RequirementSectionView: View {
    @Binding var isEditOpen: Bool
    
    var sectionTitle: String
    var isEditable: Bool = true
    
    var body: some View {
        VStack {
            HStack {
                Text(sectionTitle)
                Spacer()
                if isEditable {
                    Button(action: self.openEditAction) {
                        Text("Edit")
                    }
                    .accentColor(ThemeConstants.ACCENT_COLOR)
                }
            }
            Divider()
        }
        .padding(.top)
    }
    
    private func openEditAction() {
        self.isEditOpen.toggle()
    }
}

struct RequirementSectionView_Previews: PreviewProvider {
    static var previews: some View {
        RequirementSectionView(isEditOpen: Binding.constant(true), sectionTitle: "Assignee")
    }
}
