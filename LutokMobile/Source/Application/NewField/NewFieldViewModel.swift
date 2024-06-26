//
//  NewFieldViewModel.swift
//  LutokMobile
//
//  Created by Maria Vanurina on 25.06.2024.
//

import Foundation
import SwiftUI

class NewFieldViewModel: ObservableObject {
    
    private var service: MyFieldsService
    private var onDismiss: () -> ()
    
    @Published
    var enteredTitle = ""
    
    @Published
    var enteredPlace = ""
    
    init(service: MyFieldsService, onDismiss: @escaping () -> ()) {
        self.service = service
        self.onDismiss = onDismiss
    }
    
    func didTapCreateField(){
        createField()
    }
    
    func createField() {
        service.createField(
            title: enteredTitle,
            place: enteredPlace,
            user_id: 1) { result in
            switch result {
            case .success(let model):

                self.onDismiss()

            case .failure(let error):
                print(error.localizedDescription)
            }

            }
    }
}
