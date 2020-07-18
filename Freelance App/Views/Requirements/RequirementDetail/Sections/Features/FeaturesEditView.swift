//
//  RequirementFeaturesEdit.swift
//  Freelance App
//
//  Created by Evan Richard on 7/18/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct FeaturesEditView: View {
    @ObservedObject var requirementDetailVM: RequirementDetailViewModel
    @Binding var isEditOpen: Bool
    
    var body: some View {
        VStack {
            EditSectionHeaderView(label: "Features",action: {
                self.isEditOpen.toggle()
//                self.requirementDetailVM.updateAssignee(assigneeId: self.selectedMemberId)
            })
        }
    }
}

struct FeaturesEditView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturesEditView(requirementDetailVM: RequirementDetailViewModel(requirementTitle: "2. About Page"), isEditOpen: Binding.constant(true))
    }
}
