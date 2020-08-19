//
//  CreateProjectButtonView.swift
//  Freelance App
//
//  Created by Evan Richard on 8/18/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct CreateProjectButtonView: View {
    var isProjectActionOpen: Bool
    
    var body: some View {
        Button(action: {}) {
            ZStack {
                Rectangle()
                    .fill(Color(.systemGreen))
                    .frame(height: 1)
                Rectangle()
                    .fill(Color(.systemGreen))
                    .frame(width: 1)
            }
            .frame(maxWidth: isProjectActionOpen ? 60 : 0, maxHeight: isProjectActionOpen ? 60 : 0)
            .padding(20)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(100)
        }
    }
}

struct CreateProjectButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProjectButtonView(isProjectActionOpen: true)
    }
}
