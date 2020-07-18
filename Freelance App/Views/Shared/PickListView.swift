//
//  PickList.swift
//  Freelance App
//
//  Created by Evan Richard on 7/15/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct PickListView: View {
    @Binding var selectedLabel: String
    
    var optionList: [PickListItem]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(optionList) { option in
                Divider()
                PickListOptionView(selectedLabel: self.$selectedLabel, option: option)
            }
            Divider()
        }
    }
}

struct PickListView_Previews: PreviewProvider {
    static var previews: some View {
        PickListView(selectedLabel: Binding.constant("In Progress"), optionList: [
            PickListItem(label: "To-Do", icon: "person.circle"),
            PickListItem(label: "In Progress", icon: "scribble"),
            PickListItem(label: "Done", icon: "checkmark.circle")
        ])
    }
}
