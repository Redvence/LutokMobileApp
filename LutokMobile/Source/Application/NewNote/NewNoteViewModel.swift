//
//  NewNoteViewModel.swift
//  LutokMobile
//
//  Created by Maria Vanurina on 26.06.2024.
//

import Foundation
import SwiftUI

class NewNoteViewModel: ObservableObject {
    var id: Int
    
    private var service: NotesService
    private var onDismiss: () -> ()
    
    @Published
    var enteredText = ""

    init(id: Int, service: NotesService, onDismiss: @escaping () -> ()) {
        self.service = service
        self.onDismiss = onDismiss
        self.id = id
    }
    
    func didTapCreateNote(){
        createNote()
    }
    
    func createNote() {
        service.createNote(
            text: enteredText,
            field_id: id) { result in
            switch result {
            case .success(let model):

                self.onDismiss()

            case .failure(let error):
                print(error.localizedDescription)
            }

            }
    }
    
}
