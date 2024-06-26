//
//  MyFieldsModel.swift
//  LutokMobile
//
//  Created by Maria Vanurina on 30.03.2024.
//

import Foundation
import SwiftUI

enum MyFieldsSubview: String, Identifiable {
    case profile
    case newField
    
    var id: String {
        return self.rawValue
    }
}

class MyFieldsViewModel: ObservableObject, ProfileViewModelDelegate {
    
    @Published var activeSheet: MyFieldsSubview? = nil
    
    var navigationBinding: Binding<navigationState>
    
    // MARK: - Sugar
    
    var activeSheetBindings: Binding<MyFieldsSubview?> {
        let activeSheetPresented = Binding<MyFieldsSubview?>(
            get: { self.activeSheet },
            set: { self.activeSheet = $0 }
        )
        return activeSheetPresented
    }
    
    // MARK: - Init
    
    init(navigationBinding: Binding<navigationState>) {
        self.navigationBinding = navigationBinding
    }
    
    // MARK: - Lifecycle
    
    func onAppear() {}
    
    func reappear() {
        
    }
    
    func didLogout () {
        navigationBinding.wrappedValue = .login
    }
}
