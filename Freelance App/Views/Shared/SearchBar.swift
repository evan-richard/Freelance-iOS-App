//
//  SearchBar.swift
//  Freelance App
//
//  Created by Evan Richard on 7/3/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchString: String
    
    @State private var isEditing = false
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass").opacity(0.3)
            TextField("Search", text: $searchString)
            
            if isEditing {
                Spacer()
                Button(action: {
                    self.isEditing = false
                    self.searchString = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.primary)
                        .opacity(0.3)
                }
            }
        }
        .padding(7)
        .padding(.horizontal, 10)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(8)
        .onTapGesture {
            self.isEditing = true
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchString: Binding.constant(""))
        .environment(\.colorScheme, .dark)
    }
}
