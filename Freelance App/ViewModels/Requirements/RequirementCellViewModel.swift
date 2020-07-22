//
//  RequirementCellViewModel.swift
//  Freelance App
//
//  Created by Evan Richard on 7/8/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class RequirementCellViewModel: ObservableObject, Identifiable  {
    var id: UUID
    @Published var title: String = ""
    @Published var font: Font = Font.system(size: 30)
    @Published var paddingLeft: CGFloat = 0
    
    private var cancellables = Set<AnyCancellable>()
    
    init(title: String) {
        id = UUID()
        self.title = title
        
        switch self.title.split(separator: ".").count {
            case 2:
                self.font = Font.system(size: 20)
                self.paddingLeft = 0
                break
            case 3:
                self.font = Font.system(size: 18)
                self.paddingLeft = 25
                break
            case 4:
                self.font = Font.system(size: 16)
                self.paddingLeft = 50
                break
            default:
                self.font = Font.system(size: 26)
                self.paddingLeft = 0
        }
    }
    
}
