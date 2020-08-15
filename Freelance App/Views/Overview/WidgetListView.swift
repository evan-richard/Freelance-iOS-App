//
//  WidgetListView.swift
//  Freelance App
//
//  Created by Evan Richard on 8/8/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct WidgetListView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            RequirementsWidgetView()
            DiscussionsWidgetView()
            TimesheetWidgetView()
        }
    }
}

struct WidgetListView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetListView()
    }
}
