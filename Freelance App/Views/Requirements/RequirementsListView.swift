//
//  RequirementsList.swift
//  Freelance App
//
//  Created by Evan Richard on 7/4/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct RequirementsListView: View {
    @ObservedObject var requirementListVM: RequirementListViewModel
    @Binding var searchString: String
    @Binding var isRequirementDetailOpen: Bool
    @Binding var isPopupViewOpen: Bool
    @Binding var contextMenuAction: String
    @Binding var requirementTitle: String
    
    var body: some View {
        // We need this nested list to change the background colors
        List {
            ForEach(self.requirementListVM.requirementCellViewModels.filter({ requirementCellVM in
                if searchString != "" {
                    return requirementCellVM.title.lowercased().contains(searchString.lowercased())
                } else {
                    return true
                }
            })) { requirementCellVM in
                RequirementsListCellView(requirementCellVM: requirementCellVM, isRequirementDetailOpen: self.$isRequirementDetailOpen, isPopupViewOpen: self.$isPopupViewOpen, contextMenuAction: self.$contextMenuAction, requirementTitle: self.$requirementTitle)
            }
            .listRowBackground(Color(.secondarySystemBackground))
        }
    }
}

struct RequirementsListView_Previews: PreviewProvider {
    static var previews: some View {
        RequirementsListView(
            requirementListVM: RequirementListViewModel(),
            searchString: Binding.constant(""),
            isRequirementDetailOpen: Binding.constant(false),
            isPopupViewOpen: Binding.constant(false),
            contextMenuAction: Binding.constant(""),
            requirementTitle: Binding.constant("")
        )
    }
}
