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
    @State private var editFeaturesList: [String] = []
    @Binding var isEditOpen: Bool
    
    var body: some View {
        VStack(spacing: 40) {
            EditSectionHeaderView(label: "Features",action: {
                self.isEditOpen.toggle()
                self.requirementDetailVM.updateFeatures(features: self.editFeaturesList)
            })
            FeaturesEditListView(features: self.$editFeaturesList)
            Spacer()
        }
        .padding()
        .onAppear(perform: {
            self.editFeaturesList = self.requirementDetailVM.features
        })
    }
}

struct FeaturesEditView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturesEditView(requirementDetailVM: RequirementDetailViewModel(requirementTitle: "2. About Page"), isEditOpen: Binding.constant(true))
    }
}
