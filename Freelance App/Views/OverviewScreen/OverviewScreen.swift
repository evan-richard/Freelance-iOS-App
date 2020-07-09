//
//  OverviewScreen.swift
//  Freelance App
//
//  Created by Evan Richard on 7/3/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct OverviewScreen: View {
    @ObservedObject var projectVM: ProjectViewModel = ProjectViewModel()
    
    private let navigationLinks: [String] = [
        "Requirements",
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            VStack(alignment: .leading, spacing: 15) {
                Text(projectVM.appName)
                    .font(.title)
                Text(projectVM.customerName)
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
            Text(projectVM.description)
                .font(.body)
            List(navigationLinks, id: \.self) { link in
                NavigationLink(destination: self.getViewFromLink(link: link)) {
                    Text(link)
                        .fontWeight(.semibold)
                }
                .padding(.vertical, 8)
            }
        }
        .navigationBarTitle("Overview", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
//            pass
        }, label: {
            Image(systemName: "square.and.arrow.up")
                .foregroundColor(.purple)
        }))
        .padding()
    }
    
    private func getViewFromLink(link: String) -> some View {
        switch link {
        case "Requirements":
            return RequirementsScreen()
        default:
            return RequirementsScreen()
        }
    }
}

struct OverviewScreen_Previews: PreviewProvider {
    static var previews: some View {
        OverviewScreen()
    }
}
