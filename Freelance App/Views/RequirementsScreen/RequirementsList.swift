//
//  RequirementsList.swift
//  Freelance App
//
//  Created by Evan Richard on 7/4/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct RequirementsList: View {
    @ObservedObject var requirementListVM: RequirementListViewModel = RequirementListViewModel()
    @Binding var searchString: String
    @Binding var selectedRequirementTitle: String
    @Binding var isRequirementDetailOpen: Bool
    
    var body: some View {
        List(self.requirementListVM.requirementCellViewModels.filter({ requirementCellVM in
            if searchString != "" {
                return requirementCellVM.title.lowercased().contains(searchString.lowercased())
            } else {
                return true
            }
        })) { requirementCellVM in
            RequirementListRowItem(requirementCellVM: requirementCellVM, selectedRequirementTitle: self.$selectedRequirementTitle, isRequirementDetailOpen: self.$isRequirementDetailOpen)
        }
    }
}

struct RequirementsList_Previews: PreviewProvider {
    static var previews: some View {
        RequirementsList(searchString: Binding.constant(""), selectedRequirementTitle: Binding.constant(""), isRequirementDetailOpen: Binding.constant(false))
    }
}
