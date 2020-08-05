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
    @State private var isPopupViewOpen: Bool = false
    @State private var contextMenuAction: String = ""
    @State private var projectName: String = ""
    @State private var customerName: String = ""
    @State private var actionProjectId: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(searchString: $searchString, isSearching: $isSearching)
                ProjectListView(projectListVM: projectListVM, searchString: $searchString, isPopupViewOpen: $isPopupViewOpen, contextMenuAction: $contextMenuAction, actionProjectId: $actionProjectId, actionProjectTitle: $projectName)
                Spacer()
                ProjectsFooterView(isFilterActive: $isFilterActive, isCreateProjectOpen: $isPopupViewOpen, numberOfProjects: $projectListVM.numberOfProjects, contextMenuAction: $contextMenuAction)
            }
            .navigationBarTitle("Projects", displayMode: .large)
            .navigationBarHidden(isPopupViewOpen)
            .padding()
            .modifier(
                PopUpOverlayModifier(
                    isOpen: isPopupViewOpen,
                    popupView: self.getOverlayView()
                )
            )
        }
        .accentColor(ThemeConstants.ACCENT_COLOR)
    }
    
    private func initActions() {
        self.actionProjectId = ""
        self.projectName = ""
        self.customerName = ""
        self.hideKeyboard()
    }
    
    private func createProjectAction() {
        self.projectListVM.createProject(name: self.projectName, customer: self.customerName)
        self.initActions()
    }
    
    private func renameProjectAction() {
        self.projectListVM.renameProject(projectId: self.actionProjectId, name: self.projectName)
        self.initActions()
    }
    
    private func deleteProjectAction() {
        self.projectListVM.deleteProject(projectId: self.actionProjectId)
        self.initActions()
    }
    
    private func getOverlayView() -> AnyView {
        switch self.contextMenuAction {
            case ProjectMenuActionConstants.CREATE:
                return AnyView(CreateProjectView(
                    projectName: $projectName,
                    customerName: $customerName,
                    isOpen: $isPopupViewOpen,
                    confirmAction: self.createProjectAction
                ))
            case ProjectMenuActionConstants.RENAME:
                return AnyView(TitleConfirmationView(isOpen: $isPopupViewOpen, text: $projectName, placeholder: "Enter project title", label: "Project Title:", confirmAction: self.renameProjectAction))
            case ProjectMenuActionConstants.DELETE:
                return AnyView(DeleteConfirmationView(
                    isOpen: $isPopupViewOpen,
                    label: "Are you sure you wish to delete this project?",
                    warningLabel: "Warning: this action is permanent.",
                    confirmAction: self.deleteProjectAction
                ))
            default:
                return AnyView(WorkInProgressView())
        }
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()
    }
}
