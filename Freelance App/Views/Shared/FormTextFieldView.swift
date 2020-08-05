//
//  FormTextFieldView.swift
//  Freelance App
//
//  Created by Evan Richard on 8/2/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct FormTextFieldView: View {
    @Binding var value: String
    
    var label: String
    var placeholder: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.caption)
                .fontWeight(.semibold)
            TextField(placeholder, text: $value)
                .textFieldStyle(ReplyTextFieldStyle())
        }
    }
}

struct FormTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        FormTextFieldView(value: Binding.constant(""), label: "Project Title:", placeholder: "Enter new title")
    }
}
