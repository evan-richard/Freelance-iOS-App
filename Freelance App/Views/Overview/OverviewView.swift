//
//  OverviewScreen.swift
//  Freelance App
//
//  Created by Evan Richard on 7/3/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct OverviewView: View {
    @ObservedObject var projectListVM: ProjectListViewModel = ProjectListViewModel()
    @State private var isShareSheetOpen: Bool = false
    @State private var isProjectActionOpen: Bool = false
    @State private var isPopupViewOpen: Bool = false
    @State private var projectAction: String = ""
    @State private var newProjectTitle: String = ""
    @State private var newProjectCustomer: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .center, spacing: 40) {
                        OverviewHeaderView(
                            isShareSheetOpen: $isShareSheetOpen,
                            isProjectActionOpen: $isProjectActionOpen,
                            appName: $projectListVM.currentProjectName,
                            customerName: $projectListVM.currentProjectCustomer
                        )
                            .padding(.top, 50)
                        WidgetListView()
                    }
                    .padding(.horizontal)
                }
                ProjectActionView(projectListVM: projectListVM, isProjectActionOpen: $isProjectActionOpen, isPopupViewOpen: $isPopupViewOpen, projectAction: $projectAction)
            }
            .sheet(isPresented: $isShareSheetOpen) {
                ShareSheetView(activityItems: [
                    self.projectListVM.currentProjectName,
    //                URL(string: "freelanceapp:Invitee?projectId:\(self.projectVM.appName)")!
                    URL(string: "https://google.com")!
                ])
            }
            .navigationBarTitle("Overview")
            .navigationBarHidden(true)
            .padding(.vertical)
            .background(Color(.secondarySystemBackground))
            .modifier(
                PopUpOverlayModifier(
                    isOpen: isPopupViewOpen,
                    popupView: self.getPopupView()
                )
            )
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    private func shareProjectAction() {
        self.isShareSheetOpen.toggle()
    }
    
    private func createProjectAction() {
        self.projectListVM.createProject(name: self.newProjectTitle, customer: self.newProjectCustomer)
//        self.projectListVM.setCurrentProject(newProjectId: <#T##String#>)
    }
    
    private func renameProjectAction() {
        self.projectListVM.renameProject(name: self.newProjectTitle)
    }
    
    private func deleteProjectAction() {
        self.projectListVM.deleteProject()
    }
    
    private func getPopupView() -> AnyView {
        switch(projectAction) {
            case ProjectMenuActionConstants.DELETE:
                return AnyView(DeleteConfirmationView(
                    isOpen: $isPopupViewOpen,
                    label: "Are you sure you wish to delete \(self.projectListVM.currentProjectName)?",
                    warningLabel: "Note this action is permanent and con not be undone.",
                    confirmAction: self.deleteProjectAction
                ))
            case ProjectMenuActionConstants.RENAME:
                self.newProjectTitle = self.projectListVM.currentProjectName
                return AnyView(TitleConfirmationView(
                    isOpen: $isPopupViewOpen,
                    text: $newProjectTitle,
                    placeholder: "Enter project title",
                    label: "Project Title:",
                    confirmAction: self.renameProjectAction
                ))
            case ProjectMenuActionConstants.CREATE:
                return AnyView(CreateProjectView(
                    isOpen: $isPopupViewOpen,
                    projectName: $newProjectTitle,
                    customerName: $newProjectCustomer,
                    confirmAction: self.createProjectAction
                ))
            default:
                return AnyView(WorkInProgressView())
        }
    }
}

struct OverviewView_Previews: PreviewProvider {
    static var previews: some View {
        OverviewView()
    }
}
