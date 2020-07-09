//
//  RequirementsScreen.swift
//  Freelance App
//
//  Created by Evan Richard on 7/3/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct RequirementsScreen: View {
    var body: some View {
        VStack {
            RequirementsList()
            .navigationBarTitle("Requirements", displayMode: .large)
                .navigationBarItems(trailing:
                    HStack(spacing: 30) {
                        Button(action: {
            //            pass
                        }, label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.purple)
                        })
                        Button(action: {
            //            pass
                        }, label: {
                            Image(systemName: "square.and.pencil")
                                .foregroundColor(.purple)
                        })
                    }
                )
                .padding()
            Spacer()
        }
    }
}

struct RequirementsScreen_Previews: PreviewProvider {
    static var previews: some View {
        RequirementsScreen()
    }
}
