//
//  RequirementsScreen.swift
//  Freelance App
//
//  Created by Evan Richard on 7/3/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct RequirementsScreen: View {
    @State private var isSearching: Bool = false
    @State private var searchString: String = ""
    
    var body: some View {
        VStack {
            if isSearching {
                SearchRequirementsListView(searchString: $searchString, isSearching: $isSearching)
                .navigationBarTitle("Requirements", displayMode: .inline)
                    .navigationBarItems(trailing:
                        HStack(spacing: 35) {
                            Button(action: {
                                withAnimation {
                                    self.isSearching.toggle()
                                    self.searchString = ""
                                }
                            }, label: {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.purple)
                                    .imageScale(.large)
                            })
                            Button(action: {
                //            pass
                            }, label: {
                                Image(systemName: "square.and.pencil")
                                    .foregroundColor(.purple)
                                    .imageScale(.large)
                            })
                        }
                    )
            } else {
                RequirementsList(searchString: $searchString)
                .navigationBarTitle("Requirements", displayMode: .large)
                    .navigationBarItems(trailing:
                        HStack(spacing: 35) {
                            Button(action: {
                                withAnimation {
                                    self.isSearching.toggle()
                                }
                            }, label: {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.purple)
                                    .imageScale(.large)
                            })
                            Button(action: {
                //            pass
                            }, label: {
                                Image(systemName: "square.and.pencil")
                                    .foregroundColor(.purple)
                                    .imageScale(.large)
                            })
                        }
                    )
            }
        }
        .padding()
    }
}

struct RequirementsScreen_Previews: PreviewProvider {
    static var previews: some View {
        RequirementsScreen()
    }
}
