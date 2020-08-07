//
//  RequirementFeaturesEditListItem.swift
//  Freelance App
//
//  Created by Evan Richard on 7/18/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct FeaturesEditListItemView: View {
    @Binding var newFeature: String
    
    var index: Int
    var editIcon: AnyView
    var action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Divider()
            HStack {
                Text("\(index + 1).")
                    .foregroundColor(newFeature == "" ? .secondary : .primary)
                    .opacity(newFeature == "" ? 0.5 : 1.0)
                TextField("Add a new feature", text: $newFeature)
                Button(action: action) {
                    editIcon
                }
            }
        }
    }
}

struct FeaturesEditListItemView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturesEditListItemView(newFeature: Binding.constant("Feature that is under edit"), index: 1, editIcon: AnyView(Image(systemName: "plus.circle")), action: {})
    }
}
