//
//  ProjectsScreenFooterView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/3/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct ProjectsFooterView: View {
    @Binding var isFilterActive: Bool
    @Binding var isCreateProjectOpen: Bool
    @Binding var numberOfProjects: Int
    @Binding var contextMenuAction: String
    
    var body: some View {
        HStack {
            if self.isFilterActive {
                Button(action: self.toggleFilterAction) {
                    Image(systemName: "line.horizontal.3.decrease.circle.fill")
                        .foregroundColor(ThemeConstants.ACCENT_COLOR)
                        .imageScale(.large)
                }
            } else {
                Button(action: self.toggleFilterAction) {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                        .foregroundColor(ThemeConstants.ACCENT_COLOR)
                        .imageScale(.large)
                }
            }
            Spacer()
            Text("\(String(numberOfProjects)) Projects")
                .font(.footnote)
            Spacer()
            Button(action: self.createProjectAction) {
                Image(systemName: "square.and.pencil")
                    .foregroundColor(ThemeConstants.ACCENT_COLOR)
                    .imageScale(.large)
            }
        }
        .padding(.top, 5)
    }
    
    private func toggleFilterAction() { }
    
    private func createProjectAction() {
        self.contextMenuAction = ProjectMenuActionConstants.CREATE
        self.isCreateProjectOpen = true
    }
}

struct ProjectsFooterView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsFooterView(isFilterActive: Binding.constant(false), isCreateProjectOpen: Binding.constant(false), numberOfProjects: Binding.constant(3), contextMenuAction: Binding.constant(""))
    }
}
