//
//  ProjectViewModel.swift
//  Freelance App
//
//  Created by Evan Richard on 7/8/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import Foundation
import UIKit
import Combine

class ProjectViewModel: ObservableObject {
    @Published var appName: String = ""
    @Published var customerName: String = ""
    @Published var description: String = ""
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        if let currentProject = self.appDelegate.projectsStore!.currentProject {
            self.appName = currentProject.appName
            self.customerName = currentProject.customerName
            self.description = currentProject.description ?? ""
        }
    }
    
}
