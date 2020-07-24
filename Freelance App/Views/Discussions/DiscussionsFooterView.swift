//
//  DiscussionsFooterView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/21/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct DiscussionsFooterView: View {
    @Binding var isFilterActive: Bool
    @Binding var isCreateDiscussionOpen: Bool
    @Binding var numberOfNewMessages: Int
    
    var body: some View {
        HStack {
            if self.isFilterActive {
                Button(action: self.filterToggleAction) {
                    Image(systemName: "line.horizontal.3.decrease.circle.fill")
                        .foregroundColor(.purple)
                        .imageScale(.large)
                }
            } else {
                Button(action: self.filterToggleAction) {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                        .foregroundColor(.purple)
                        .imageScale(.large)
                }
            }
            Spacer()
            Text("No New Messages")
                .font(.footnote)
            Spacer()
            Button(action: self.createDiscussionAction) {
                Image(systemName: "square.and.pencil")
                    .foregroundColor(.purple)
                    .imageScale(.large)
            }
            .sheet(isPresented: $isCreateDiscussionOpen, content: {
                WorkInProgressView()
            })
        }
        .padding(.top, 5)
    }
    
    private func filterToggleAction() { }
    
    private func createDiscussionAction() {
        self.isCreateDiscussionOpen = true
    }
}

struct DiscussionsFooterView_Previews: PreviewProvider {
    static var previews: some View {
        DiscussionsFooterView(isFilterActive: Binding.constant(false), isCreateDiscussionOpen: Binding.constant(false), numberOfNewMessages: Binding.constant(2)
        )
    }
}
