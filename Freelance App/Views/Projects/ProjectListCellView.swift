//
//  ProjectListCell.swift
//  Freelance App
//
//  Created by Evan Richard on 7/7/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct ProjectListCellView: View {
    @ObservedObject var projectCellVM: ProjectCellViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(projectCellVM.appName).fontWeight(.semibold)
            Text(projectCellVM.customerName).font(.subheadline).foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
}

struct ProjectListCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectListCellView(projectCellVM: ProjectCellViewModel(projectId: "123", appName: "Application Name:", customerName: "Customer Name"))
    }
}
