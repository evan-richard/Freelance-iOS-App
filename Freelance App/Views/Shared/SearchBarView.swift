//
//  SearchBar.swift
//  Freelance App
//
//  Created by Evan Richard on 7/3/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchString: String
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass").opacity(0.3)
                TextField("Search", text: $searchString)
                
                if !searchString.isEmpty {
                    Button(action: {
                        self.searchString = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.primary)
                            .opacity(0.3)
                    }
                }
            }
            .padding(7)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(8)
            .onTapGesture {
                withAnimation {
                    self.isSearching = true
                }
            }
            if isSearching {
                Button(action: {
                    withAnimation {
                        self.isSearching = false
                        self.searchString = ""
                        self.hideKeyboard()
                    }
                }) {
                    Text("Cancel")
                }
                .accentColor(.purple)
            }
        }
        .frame(height: 40)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchString: Binding.constant(""), isSearching: Binding.constant(false))
    }
}