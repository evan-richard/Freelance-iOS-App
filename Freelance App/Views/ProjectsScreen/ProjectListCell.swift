//
//  ProjectListCell.swift
//  Freelance App
//
//  Created by Evan Richard on 7/7/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct ProjectListCell: View {
    @ObservedObject var projectCellVM: ProjectCellViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(projectCellVM.appName).fontWeight(.semibold)
                Text(projectCellVM.customerName).font(.subheadline).foregroundColor(.secondary)
            }
            .padding(.vertical, 8)
            Spacer()
        }
    }
}

struct ProjectListCell_Previews: PreviewProvider {
    static var previews: some View {
        ProjectListCell(projectCellVM: ProjectCellViewModel(projectId: "123", appName: "Application Name:", customerName: "Customer Name"))
    }
}
