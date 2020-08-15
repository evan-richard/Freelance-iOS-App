//
//  RequirementsWidgetViewModel.swift
//  Freelance App
//
//  Created by Evan Richard on 8/9/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import Foundation
import Combine
import UIKit

class RequirementsWidgetViewModel: ObservableObject {
    @Published var totalNum: Int = 0
    @Published var numOfDone: Int = 0
    @Published var numOfInProgress: Int = 0
    @Published var numOfToDo: Int = 0
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.appDelegate.sessionInitGroup.notify(queue: .main) {
            self.appDelegate.requirementsStore?.$requirements.sink { requirements in
                self.resetCount()
                requirements.forEach { requirement in
                    self.totalNum += 1
                    switch(requirement.status) {
                        case RequirementStatusConstants.DONE:
                            self.numOfDone += 1
                            break
                        case RequirementStatusConstants.IN_PROGRESS:
                            self.numOfInProgress += 1
                            break
                        case RequirementStatusConstants.TO_DO:
                            self.numOfToDo += 1
                            break
                        default:
                            break
                    }
                }
            }
            .store(in: &self.cancellables)
        }
    }
    
    private func resetCount() {
        self.totalNum = 0
        self.numOfDone = 0
        self.numOfInProgress = 0
        self.numOfToDo = 0
    }
}
