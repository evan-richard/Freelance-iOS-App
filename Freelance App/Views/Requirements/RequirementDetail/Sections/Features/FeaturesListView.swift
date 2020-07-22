//
//  RequirementFeaturesListView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/17/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct FeaturesListView: View {
    var features: [String]?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if features != nil && features!.count > 0 {
                ForEach(features!.indices, id: \.self) { idx in
                    FeaturesListItemView(index: idx, feature: self.features![idx])
                }
            } else {
                Text("None")
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct FeaturesListView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturesListView(features: ["Feature 1 description goes here", "And then another feature description follows that one", "We may have a bit of a longer feature description at times, but that should still be OK", "And a short one too"])
    }
}
