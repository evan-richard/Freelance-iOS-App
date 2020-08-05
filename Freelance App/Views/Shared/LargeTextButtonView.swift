//
//  LargeTextButtonView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/25/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct LargeTextButtonView: View {
    var label: String
    var action: () -> Void
    var isPrimary: Bool
    var primaryColor: Color = ThemeConstants.ACCENT_COLOR_BACKGROUND
    
    @ViewBuilder
    var body: some View {
        if isPrimary {
            Button(action: action) {
                Text(label)
                    .fontWeight(.semibold)
                    .font(.headline)
                    .foregroundColor(ThemeConstants.ACCENT_COLOR_FOREGROUND)
                    .frame(width: 150, height: 50)
                    .background(primaryColor)
                    .cornerRadius(30)
            }
            .accentColor(.white)
        } else {
            Button(action: action) {
                Text(label)
                    .fontWeight(.semibold)
                    .font(.headline)
                    .frame(width: 150, height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .strokeBorder(
                                Color.secondary.opacity(0.5), lineWidth: 1
                            )
                    )
            }
            .accentColor(.primary)
        }
    }
}

struct LargeTextButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LargeTextButtonView(label: "Save", action: {}, isPrimary: true)
    }
}
