//
//  ProjectActionView.swift
//  Freelance App
//
//  Created by Evan Richard on 8/13/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct ProjectActionView: View {
    @ObservedObject var projectListVM: ProjectListViewModel
    @Binding var isProjectActionOpen: Bool
    @Binding var isPopupViewOpen: Bool
    @Binding var projectAction: String
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                ProjectPickerView(
                    isProjectActionOpen: $isProjectActionOpen,
                    appName: $projectListVM.currentProjectName,
                    customerName: $projectListVM.currentProjectCustomer
                )
                Spacer()
            }
            
            ProjectListView(projectListVM: projectListVM, isProjectActionOpen: $isProjectActionOpen)
                .shadow(radius: 5)
            
            Spacer()
            
            HStack {
                Spacer()
                Button(action: self.deleteProjectAction) {
                    IconConstants.DELETE
                        .imageScale(.large)
                        .frame(maxWidth: 70, maxHeight: 70)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(100)
                }
                .offset(x: isProjectActionOpen ? 0 : 75, y: 0)
                .shadow(radius: 10)
                Spacer()
                CreateProjectButtonView(isProjectActionOpen: isProjectActionOpen, createProjectAction: self.createProjectAction)
                    .offset(x: 0, y: isProjectActionOpen ? -50 : 0)
                    .shadow(radius: 10)
                Spacer()
                Button(action: self.editProjectAction) {
                    IconConstants.EDIT
                        .imageScale(.large)
                        .frame(maxWidth: 70, maxHeight: 70)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(100)
                }
                .offset(x: isProjectActionOpen ? 0 : -75, y: 0)
                .shadow(radius: 10)
                Spacer()
            }
            .offset(x: 0, y: isProjectActionOpen ? -40 : 150)
            .animation(Animation.default.delay(0.0))
        }
        .padding()
        .padding(.top, 60)
        .background(BlurStyle())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .opacity(self.isProjectActionOpen ? 1.0 : 0.0)
        .animation(Animation.default.delay(self.isProjectActionOpen ? 0.0 : 0.15))
//        .onTapGesture {
//            self.isProjectActionOpen.toggle()
//        }
    }
    
    private func createProjectAction() {
        withAnimation {
            self.isProjectActionOpen.toggle()
            self.projectAction = ProjectMenuActionConstants.CREATE
            self.isPopupViewOpen.toggle()
        }
    }
    
    private func editProjectAction() {
        withAnimation {
            self.isProjectActionOpen.toggle()
            self.projectAction = ProjectMenuActionConstants.RENAME
            self.isPopupViewOpen.toggle()
        }
    }
    
    private func deleteProjectAction() {
        withAnimation {
            self.isProjectActionOpen.toggle()
            self.projectAction = ProjectMenuActionConstants.DELETE
            self.isPopupViewOpen.toggle()
        }
    }
}

struct ProjectActionView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectActionView(projectListVM: ProjectListViewModel(), isProjectActionOpen: Binding.constant(false), isPopupViewOpen: Binding.constant(false), projectAction: Binding.constant(""))
    }
}
