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
                    Button(action: self.clearSearchBarAction) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.primary)
                            .opacity(0.3)
                    }
                }
            }
            .padding(7)
            .background(Color(.systemBackground))
            .cornerRadius(8)
            .onTapGesture {
                withAnimation {
                    self.isSearching = true
                }
            }
            if isSearching {
                Button(action: self.cancelSearchAction) {
                    Text("Cancel")
                }
                .accentColor(ThemeConstants.ACCENT_COLOR)
            }
        }
        .frame(height: 40)
    }
    
    private func clearSearchBarAction() {
        self.searchString = ""
    }
    
    private func cancelSearchAction() {
        withAnimation {
            self.isSearching = false
            self.searchString = ""
            self.hideKeyboard()
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchString: Binding.constant(""), isSearching: Binding.constant(false))
    }
}
