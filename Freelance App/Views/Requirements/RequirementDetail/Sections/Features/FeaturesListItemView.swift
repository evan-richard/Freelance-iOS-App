//
//  RequirementFeaturesListItemView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/17/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct FeaturesListItemView: View {
    var index: Int
    var feature: String
    
    var body: some View {
        HStack() {
            // Bullet point preprended to feature
            Text("\(index + 1). \(feature)")
                .foregroundColor(.secondary)
                .lineLimit(5)
        }
    }
}

struct FeaturesListItemView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturesListItemView(index: 1, feature: "Feature 1 description goes here")
    }
}
