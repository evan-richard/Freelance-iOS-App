//
//  RequirementFeaturesSection.swift
//  Freelance App
//
//  Created by Evan Richard on 7/17/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct FeaturesView: View {
    @ObservedObject var requirementDetailVM: RequirementDetailViewModel
    @State private var isEditOpen: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            RequirementSectionView(isEditOpen: $isEditOpen, sectionTitle: "Features")
            FeaturesListView(features: requirementDetailVM.features)
        }
        .sheet(isPresented: $isEditOpen) {
            FeaturesEditView(requirementDetailVM: self.requirementDetailVM, isEditOpen: self.$isEditOpen)
        }
    }
}

struct FeaturesView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturesView(requirementDetailVM: RequirementDetailViewModel())
    }
}
