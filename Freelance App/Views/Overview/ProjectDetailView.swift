//
//  ProjectDetailView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/12/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct ProjectDetailView: View {
    @ObservedObject var projectVM: ProjectViewModel
    
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
        }
    }
}

struct ProjectDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectDetailView(projectVM: ProjectViewModel())
    }
}
