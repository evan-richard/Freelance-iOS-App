//
//  RequirementFeaturesEditListView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/18/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct FeaturesEditListView: View {
    @Binding var features: [String]
    
    var body: some View {
        VStack {
            ForEach(features, id: \.self) { feature in
                FeaturesEditListItemView()
            }
        }
    }
}

struct FeaturesEditListView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturesEditListView(features: Binding.constant(["Feature 1 description goes here", "And then another feature description follows that one", "We may have a bit of a longer feature description at times, but that should still be OK", "And a short one too"]))
    }
}
