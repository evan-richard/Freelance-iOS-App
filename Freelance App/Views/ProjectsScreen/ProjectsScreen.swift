//
//  ProjectsScreen.swift
//  Freelance App
//
//  Created by Evan Richard on 7/3/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct ProjectsScreen: View {
    @ObservedObject var projectListVM: ProjectListViewModel = ProjectListViewModel()
    
    @State private var searchString: String = ""
    @State private var isFilterActive: Bool = false
    @State private var isCreateProjectOpen: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(searchString: $searchString)
                ProjectListView(projectListVM: projectListVM)
                Spacer()
                ProjectsScreenFooterView(isFilterActive: $isFilterActive, isCreateProjectOpen: $isCreateProjectOpen, numberOfProjects: $projectListVM.numberOfProjects)
            }
            .navigationBarTitle("Projects", displayMode: .large)
            .padding()
        }
        .accentColor(.purple)
    }
}

struct ProjectsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsScreen()
    }
}
