//
//  OpaqueRoundedTextFieldStyle.swift
//  Freelance App
//
//  Created by Evan Richard on 7/24/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

public struct ReplyTextFieldStyle : TextFieldStyle {
    var isError: Bool = false
    
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .strokeBorder(
                        isError ? ThemeConstants.DANGER_COLOR.opacity(0.5) : Color.secondary.opacity(0.5), lineWidth: 1
                    )
            )
    }
}
