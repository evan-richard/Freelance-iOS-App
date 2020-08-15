//
//  RadialGradientStyle.swift
//  Freelance App
//
//  Created by Evan Richard on 8/8/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct RadialGradientStyle: View {
    var accentColor: Color
    
    var body: some View {
        RadialGradient(
            gradient: Gradient(colors: [accentColor, .white]),
            center: .center,
            startRadius: 2,
            endRadius: 650
        )
    }
}

struct RadialGradientStyle_Previews: PreviewProvider {
    static var previews: some View {
        RadialGradientStyle(accentColor: .blue)
    }
}
