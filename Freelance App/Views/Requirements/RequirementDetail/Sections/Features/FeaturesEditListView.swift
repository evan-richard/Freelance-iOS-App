//
//  RequirementFeaturesEditListView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/18/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct FeaturesEditListView: View {
    @State private var newFeature: String = ""
    @Binding var features: [String]
    
    var minusIcon: AnyView = AnyView(
        Image(systemName: "i.circle")
            .foregroundColor(.red)
            .rotationEffect(.degrees(90))
    )
    
    var plusIcon: AnyView = AnyView(
        Image(systemName: "plus.circle")
            .foregroundColor(.green)
    )
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if (self.features.count > 0) {
                    ForEach(features.indices, id: \.self) { idx in
                        FeaturesEditListItemView(newFeature: self.$features[idx],
                                                 index: idx,
                                                 editIcon: self.minusIcon,
                                                 action: { self.deleteRow(idx: idx) })
                    }
                }
                FeaturesEditListItemView(newFeature: $newFeature,
                                         index: self.features.count,
                                         editIcon: plusIcon,
                                         action: addRow)
                Divider()
            }
        }
    }
    
    private func deleteRow(idx: Int) -> Void {
        self.features.remove(at: idx)
    }
    
    private func addRow() -> Void {
        self.features.append(self.newFeature)
        self.newFeature = ""
    }
}

struct FeaturesEditListView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturesEditListView(features: Binding.constant(["Feature 1 description goes here", "And then another feature description follows that one", "We may have a bit of a longer feature description at times, but that should still be OK", "And a short one too"]))
    }
}
