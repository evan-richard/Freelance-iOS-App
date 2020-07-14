//
//  RequirementDetailSectionView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/12/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct RequirementDetailSectionView: View {
    @State private var isEditOpen: Bool = false
    
    var sectionTitle: String
    
    @Binding var sectionValueId: String
    
    var body: some View {
        VStack {
            HStack {
                Text(sectionTitle)
                Spacer()
                Button(action: {
                    self.isEditOpen.toggle()
                }) {
                    Text("Edit")
                }
                .accentColor(.purple)
            }
            Divider()
        }
        .sheet(isPresented: $isEditOpen) {
            self.getViewForSection()
        }
    }
    
    private func getViewForSection() -> some View {
        switch self.sectionTitle {
            case "Assignee":
                return AnyView(RequirementEditAssignee(isEditOpen: $isEditOpen, sectionValueId: $sectionValueId))
            default:
                return AnyView(WorkInProgressView())
        }
    }
}

struct RequirementDetailSectionView_Previews: PreviewProvider {
    static var previews: some View {
        RequirementDetailSectionView(sectionTitle: "Assignee", sectionValueId: Binding.constant("test1"))
    }
}
