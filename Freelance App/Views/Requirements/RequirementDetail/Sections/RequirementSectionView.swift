//
//  RequirementDetailSectionView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/12/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct RequirementSectionView: View {
    @ObservedObject var requirementDetailVM: RequirementDetailViewModel
    @Binding var isEditOpen: Bool
    
    var sectionTitle: String
    
    var body: some View {
        VStack {
            HStack {
                Text(sectionTitle)
                Spacer()
                Button(action: self.openEditAction) {
                    Text("Edit")
                }
                .accentColor(.purple)
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
        RequirementSectionView(requirementDetailVM: RequirementDetailViewModel(), isEditOpen: Binding.constant(true), sectionTitle: "Assignee")
    }
}
