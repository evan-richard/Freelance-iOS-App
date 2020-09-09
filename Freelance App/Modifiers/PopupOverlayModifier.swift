//
//  PopupOverlayModifier.swift
//  Freelance App
//
//  Created by Evan Richard on 7/24/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct PopUpOverlayModifier: ViewModifier {
    var isOpen: Bool
    var popupView: AnyView
    
    @ViewBuilder
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    ZStack {
                        if self.isOpen {
                            Rectangle()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .foregroundColor(.black)
                                .opacity(0.5)
                        }
                        self.popupView
                            .zIndex(.infinity)
                            .padding()
                            .padding(.vertical)
                            .padding(.top, 70)
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(30)
                            .frame(height: geometry.size.height, alignment: .top)
                            .offset(y: self.isOpen ? -30 : -geometry.size.height)
                            .animation(Animation.easeInOut(duration: 0.6))
                            .shadow(radius: 5)
                    }
                }
                .edgesIgnoringSafeArea(.all)
            )
    }
}
