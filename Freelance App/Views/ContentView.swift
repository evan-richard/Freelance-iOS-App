//
//  ContentView.swift
//  Freelance App
//
//  Created by Evan Richard on 7/3/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var loginVM: LoginViewModel = LoginViewModel()
    
    var body: some View {
        Group {
            if (loginVM.isAuthenticated) {
                OverviewView()
            } else {
                LoginView(loginVM: loginVM)
            }
        }
        .onAppear {
            UINavigationBar.appearance().backgroundColor = .secondarySystemBackground
            UITableView.appearance().backgroundColor = .secondarySystemBackground
            UITableViewCell.appearance().backgroundColor = .secondarySystemBackground
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
