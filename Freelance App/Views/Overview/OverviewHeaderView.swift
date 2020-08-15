//
//  OverviewHeaderView.swift
//  Freelance App
//
//  Created by Evan Richard on 8/14/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct OverviewHeaderView: View {
    @Binding var isShareSheetOpen: Bool
    @Binding var isProjectActionOpen: Bool
    @Binding var appName: String
    @Binding var customerName: String
    
    var body: some View {
        ZStack {
            HStack {
                Button(action: self.openShareSheet) {
                    IconConstants.SHARE
                        .padding(20)
                        .offset(y: -3)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(100)
                }
                Spacer()
            }
            ProjectPickerView(
                isProjectActionOpen: $isProjectActionOpen,
                appName: $appName,
                customerName: $customerName
            )
        }
    }
    
    private func openShareSheet() {
        self.isShareSheetOpen.toggle()
    }
}

struct OverviewHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        OverviewHeaderView(
            isShareSheetOpen: Binding.constant(false),
            isProjectActionOpen: Binding.constant(false),
            appName: Binding.constant("Navigation Website"),
            customerName: Binding.constant("Navigator Inc.")
        )
    }
}
