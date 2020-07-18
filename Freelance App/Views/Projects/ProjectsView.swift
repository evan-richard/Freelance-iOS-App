//
//  ProjectsScreen.swift
//  Freelance App
//
//  Created by Evan Richard on 7/3/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct ProjectsView: View {
    @ObservedObject var projectListVM: ProjectListViewModel = ProjectListViewModel()
    @State private var searchString: String = ""
    @State private var isSearching: Bool = false
    @State private var isFilterActive: Bool = false
    @State private var isCreateProjectOpen: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(searchString: $searchString, isSearching: $isSearching)
                ProjectListView(projectListVM: projectListVM, searchString: $searchString)
                Spacer()
                ProjectsFooterView(isFilterActive: $isFilterActive, isCreateProjectOpen: $isCreateProjectOpen, numberOfProjects: $projectListVM.numberOfProjects)
            }
            .navigationBarTitle("Projects", displayMode: .large)
            .padding()
        }
        .accentColor(.purple)
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()
    }
}
