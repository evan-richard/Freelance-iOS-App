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
            gradient: Gradient(colors: [accentColor, Color(red: 245/255, green: 245/255, blue: 245/255)]),
            center: .center,
            startRadius: 2,
            endRadius: 750
        )
    }
}

struct RadialGradientStyle_Previews: PreviewProvider {
    static var previews: some View {
        RadialGradientStyle(accentColor: .blue)
    }
}
