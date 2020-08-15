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
            
            Spacer()
        }
        .padding()
        .padding(.vertical, 60)
        .background(BlurStyle())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .opacity(self.isProjectActionOpen ? 1.0 : 0.0)
        .animation(Animation.default.delay(self.isProjectActionOpen ? 0.0 : 0.3))
    }
    
    private func closeProjectAction() {
        withAnimation {
            self.isProjectActionOpen.toggle()
        }
    }
}

struct ProjectActionView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectActionView(projectListVM: ProjectListViewModel(), isProjectActionOpen: Binding.constant(false))
    }
}
