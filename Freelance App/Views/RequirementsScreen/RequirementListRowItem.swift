//
//  RequirementListRowItem.swift
//  Freelance App
//
//  Created by Evan Richard on 7/4/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct RequirementListRowItem: View {
    @ObservedObject var requirementCellVM: RequirementCellViewModel
    
    @State private var isRequirementDetailOpen: Bool = false
    
    var body: some View {
        Button(action: {
            self.isRequirementDetailOpen = true
        }, label: {
            Text(requirementCellVM.title)
                .foregroundColor(.purple)
                .padding(.leading, requirementCellVM.paddingLeft)
                .padding(.vertical, 8)
                .font(requirementCellVM.font)
        })
        .sheet(isPresented: self.$isRequirementDetailOpen, content: {
            RequirementsDetailView(requirementTitle: self.requirementCellVM.title, isRequirementDetailViewOpen: self.$isRequirementDetailOpen)
        })
    }
}

struct RequirementListRowItem_Previews: PreviewProvider {
    static var previews: some View {
        RequirementListRowItem(requirementCellVM: RequirementCellViewModel(title: "2. About Page"))
    }
}
