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
    
    var body: some View {
        HStack {
            if self.isFilterActive {
                Button(action: {
//                            pass
                }) {
                    Image(systemName: "line.horizontal.3.decrease.circle.fill")
                        .foregroundColor(.purple)
                        .imageScale(.large)
                }
            } else {
                Button(action: {
//                            pass
                }) {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                        .foregroundColor(.purple)
                        .imageScale(.large)
                }
            }
            Spacer()
            Text("\(String(numberOfProjects)) Projects")
                .font(.footnote)
            Spacer()
            Button(action: {
                self.isCreateProjectOpen = true
            }) {
                Image(systemName: "square.and.pencil")
                    .foregroundColor(.purple)
                    .imageScale(.large)
            }
            .sheet(isPresented: $isCreateProjectOpen, content: {
                CreateProjectView()
            })
        }
        .padding(.top, 5)
    }
}

struct ProjectsFooterView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsFooterView(isFilterActive: Binding.constant(false), isCreateProjectOpen: Binding.constant(false), numberOfProjects: Binding.constant(3))
    }
}
