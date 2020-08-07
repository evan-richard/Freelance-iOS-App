//
//  RequirementsScreen.swift
//  Freelance App
//
//  Created by Evan Richard on 7/3/20.
//  Copyright © 2020 EvanRichard. All rights reserved.
//

import SwiftUI

struct RequirementsView: View {
    @ObservedObject var requirementListVM: RequirementListViewModel = RequirementListViewModel()
    @State private var isSearching: Bool = false
    @State private var searchString: String = ""
    @State private var isRequirementDetailOpen: Bool = false
    @State private var isPopupViewOpen: Bool = false
    @State private var popupTextFieldText: String = ""
    @State private var contextMenuAction: String = ""
    
    var body: some View {
        VStack {
            if (requirementListVM.requirementCellViewModels.count > 0) {
                    if isSearching {
                        SearchBarView(searchString: $searchString, isSearching: $isSearching)
                    }
                    RequirementsListView(
                        requirementListVM: requirementListVM,
                        searchString: $searchString,
                        isRequirementDetailOpen: $isRequirementDetailOpen,
                        isPopupViewOpen: $isPopupViewOpen,
                        contextMenuAction: $contextMenuAction,
                        requirementTitle: $popupTextFieldText
                    )
                } else {
                    Spacer()
                    EmptyRequirmentListView(
                        isPopupViewOpen: $isPopupViewOpen,
                        contextMenuAction: $contextMenuAction
                    )
                    Spacer()
                }
        }
        .navigationBarTitle("Requirements", displayMode: isSearching ? .inline : .large)
        .navigationBarItems(trailing:
            HStack(spacing: 35) {
                if !isSearching && requirementListVM.requirementCellViewModels.count > 0 {
                    Button(action: self.searchAction) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(ThemeConstants.ACCENT_COLOR)
                            .imageScale(.large)
                    }
                }
            }
        )
        .navigationBarHidden(isPopupViewOpen)
        .padding()
        .modifier(
            PopUpOverlayModifier(
                isOpen: isPopupViewOpen,
                popupView: self.contextMenuAction == RequirementMenuActionConstants.DELETE ?
                    AnyView(DeleteConfirmationView(
                        isOpen: $isPopupViewOpen,
                        label: "Are you sure you wish to delete this requirement?",
                        warningLabel: "Note deleting a requirement will also delete any of its subrequirements.",
                        confirmAction: self.getContextMenuAction()
                    ))
                    : AnyView(TitleConfirmationView(
                        isOpen: $isPopupViewOpen,
                        text: $popupTextFieldText,
                        placeholder: "Enter requirement title",
                        label: "Requirement Title:",
                        confirmAction: self.getContextMenuAction()
                    ))
            )
        )
        .sheet(isPresented: self.$isRequirementDetailOpen, content: {
            RequirementDetailView(isRequirementDetailViewOpen: self.$isRequirementDetailOpen)
        })
    }
    
    private func searchAction() {
        withAnimation {
            self.isSearching.toggle()
            self.searchString = ""
        }
    }
    
    private func getContextMenuAction() -> (() -> Void) {
        switch self.contextMenuAction {
            case RequirementMenuActionConstants.INSERT_BEFORE:
                return self.insertBeforeAction
            case RequirementMenuActionConstants.INSERT_AFTER:
                return self.insertAfterAction
            case RequirementMenuActionConstants.ADD_CHILD:
                return self.addChildAction
            case RequirementMenuActionConstants.RENAME:
                return self.renameAction
            case RequirementMenuActionConstants.DELETE:
                return self.deleteAction
            case RequirementMenuActionConstants.CREATE:
                return self.createRequirementAction
            default:
                return {}
            }
    }
    
    private func createRequirementAction() {
        self.hideKeyboard()
        self.requirementListVM.createRequirement(title: self.popupTextFieldText)
    }
    
    private func renameAction() {
        self.hideKeyboard()
        self.requirementListVM.renameRequirement(title: self.popupTextFieldText)
    }
    
    private func insertBeforeAction() {
        self.hideKeyboard()
        self.requirementListVM.insertRequirement(isInsertBefore: true, title: self.popupTextFieldText)
    }
    
    private func insertAfterAction() {
        self.hideKeyboard()
        self.requirementListVM.insertRequirement(isInsertBefore: false, title: self.popupTextFieldText)
    }
    
    private func addChildAction() {
        self.hideKeyboard()
        self.requirementListVM.addChildRequirement(title: self.popupTextFieldText)
    }
    
    private func deleteAction() {
        self.requirementListVM.deleteRequirement()
    }
}

struct RequirementsView_Previews: PreviewProvider {
    static var previews: some View {
        RequirementsView()
    }
}
