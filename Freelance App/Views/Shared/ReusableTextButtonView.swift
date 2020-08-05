//
//  ReusableTextButtonView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/19/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct ReusableTextButtonView: View {
    var label: String
    
    var body: some View {
        Text(label)
            .fontWeight(.semibold)
            .foregroundColor(ThemeConstants.ACCENT_COLOR_FOREGROUND)
            .padding(.vertical, 6)
            .padding(.horizontal)
            .background(ThemeConstants.ACCENT_COLOR_BACKGROUND)
            .cornerRadius(30)
    }
}

struct ReusableTextButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ReusableTextButtonView(label: "Save")
    }
}
