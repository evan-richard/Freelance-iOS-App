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
                ProjectActionView(projectListVM: projectListVM, isProjectActionOpen: $isProjectActionOpen)
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
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    private func shareProjectAction() {
        self.isShareSheetOpen.toggle()
    }
}

struct OverviewView_Previews: PreviewProvider {
    static var previews: some View {
        OverviewView()
    }
}
