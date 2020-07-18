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
                ProjectsView()
            } else {
                LoginView(loginVM: loginVM)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
