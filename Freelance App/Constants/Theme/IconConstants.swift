//
//  IconConstants.swift
//  Freelance App
//
//  Created by Evan Richard on 8/3/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct IconConstants {
    static var COPY: Image = Image(systemName: "doc.on.doc")
    static var EDIT: Image = Image(systemName: "pencil.and.ellipsis.rectangle")
    static var DELETE: AnyView = AnyView(Image(systemName: "trash")
        .foregroundColor(ThemeConstants.DANGER_COLOR))
    static var CANCEL: Image = Image(systemName: "x.circle.fill")
    static var CANCEL_LARGE: AnyView = AnyView(
        Image(systemName: "x.circle.fill")
            .resizable()
            .frame(maxWidth: 30, maxHeight: 30)
            .padding()
    )
    static var SHARE: Image = Image(systemName: "square.and.arrow.up")
    static var DROPDOWN_ARROW: Image = Image(systemName: "chevron.down")
    static var INSERT_BEFORE: Image = Image(systemName: "arrow.turn.up.right")
    static var INSERT_AFTER: Image = Image(systemName: "arrow.turn.down.right")
    static var ADD_CHILD: Image = Image(systemName: "arrow.down.right")
    static var UNAVAILABLE: Image = Image(systemName: "questionmark.diamond")
}
