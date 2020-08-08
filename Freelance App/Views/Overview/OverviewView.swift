//
//  OverviewScreen.swift
//  Freelance App
//
//  Created by Evan Richard on 7/3/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct OverviewView: View {
    @ObservedObject var projectVM: ProjectViewModel = ProjectViewModel()
    @State private var isShareSheetOpen: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            ProjectDetailView(projectVM: projectVM)
            Spacer()
            NavigationListView()
                .padding(.bottom, 20)
        }
        .sheet(isPresented: $isShareSheetOpen) {
            ShareSheetView(activityItems: [
                self.projectVM.appName,
//                URL(string: "freelanceapp:Invitee?projectId:\(self.projectVM.appName)")!
                URL(string: "https://google.com")!
            ])
        }
        .navigationBarTitle("Overview", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: self.shareProjectAction) {
            Image(systemName: "square.and.arrow.up")
                .foregroundColor(ThemeConstants.ACCENT_COLOR)
                .imageScale(.large)
        })
        .padding()
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
