//
//  ProjectPickerView.swift
//  Freelance App
//
//  Created by Evan Richard on 8/8/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct ProjectPickerView: View {
    @Binding var isProjectActionOpen: Bool
    @Binding var appName: String
    @Binding var customerName: String
    
    var body: some View {
        Button(action: self.toggleProjectAction) {
            VStack {
                HStack {
                    Text(appName)
                        .font(.system(size: 20))
                        .padding(.horizontal)
                    IconConstants.DROPDOWN_ARROW
                }
                Text(customerName)
                    .foregroundColor(.secondary)
            }
        }
        .accentColor(.primary)
    }
    
    private func toggleProjectAction() {
        withAnimation {
            self.isProjectActionOpen.toggle()
        }
    }
}

struct ProjectPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectPickerView(
            isProjectActionOpen: Binding.constant(false),
            appName: Binding.constant("Navigation Website"),
            customerName: Binding.constant("Navigator Inc.")
        )
    }
}
