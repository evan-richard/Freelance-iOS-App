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
    @Binding var selectedRequirementTitle: String
    @Binding var isRequirementDetailOpen: Bool
    
    var body: some View {
        Button(action: {
            self.isRequirementDetailOpen.toggle()
            self.selectedRequirementTitle = self.requirementCellVM.title
        }, label: {
            Text(requirementCellVM.title)
                .foregroundColor(.purple)
                .padding(.leading, requirementCellVM.paddingLeft)
                .padding(.vertical, 8)
                .font(requirementCellVM.font)
        })
    }
}

struct RequirementListRowItem_Previews: PreviewProvider {
    static var previews: some View {
        RequirementListRowItem(requirementCellVM: RequirementCellViewModel(title: "2. About Page"), selectedRequirementTitle: Binding.constant(""), isRequirementDetailOpen: Binding.constant(false))
    }
}
