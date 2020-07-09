//
//  GenericCellViewModel.swift
//  Freelance App
//
//  Created by Evan Richard on 7/7/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import Foundation
import Combine

class ProjectCellViewModel: ObservableObject, Identifiable  {
    var id: UUID
    @Published var projectId: String = ""
    @Published var appName: String = ""
    @Published var customerName: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    static func newGenericItem() -> ProjectCellViewModel {
        ProjectCellViewModel(projectId: "", appName: "", customerName: "")
    }
    
    init(projectId: String, appName: String, customerName: String) {
        id = UUID()
        self.projectId = projectId
        self.appName = appName
        self.customerName = customerName
    }
    
}
