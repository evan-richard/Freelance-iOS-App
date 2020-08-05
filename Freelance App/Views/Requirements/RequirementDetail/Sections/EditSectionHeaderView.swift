//
//  RequirementDetailEditHeader.swift
//  Freelance App
//
//  Created by Evan Richard on 7/18/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct EditSectionHeaderView: View {
    var label: String
    var action: () -> Void
    
    var body: some View {
        HStack {
            Text(label)
                .font(.title)
            Spacer()
            Button(action: action) {
                ReusableTextButtonView(label: "Save")
            }
            .accentColor(ThemeConstants.ACCENT_COLOR)
        }
    }
}

struct EditSectionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        EditSectionHeaderView(label: "Assignee", action: {})
    }
}
