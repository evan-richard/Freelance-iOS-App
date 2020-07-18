//
//  PickListOption.swift
//  Freelance App
//
//  Created by Evan Richard on 7/15/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct PickListOptionView: View {
    @Binding var selectedLabel: String
    
    var option: PickListItem
    
    var body: some View {
        Button(action: {
            self.selectedLabel = self.option.label
        }) {
            HStack {
                Image(systemName: option.icon ?? "")
                    .foregroundColor(.purple)
                Text(option.label)
                    .foregroundColor(.primary)
                Spacer()
                if self.selectedLabel == self.option.label {
                    Image(systemName: "checkmark")
                        .foregroundColor(.purple)
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
        }
    }
}

struct PickListOptionView_Previews: PreviewProvider {
    static var previews: some View {
        PickListOptionView(selectedLabel: Binding.constant("Option"), option: PickListItem(label: "Option", icon: "person.circle.fill"))
    }
}
