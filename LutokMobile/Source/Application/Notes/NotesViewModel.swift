//
//  NoteViewModel.swift
//  LutokMobile
//
//  Created by Maria Vanurina on 25.06.2024.
//

import Foundation
import SwiftUI

class NotesViewModel: ObservableObject {
    
    var id: Int
    
    @Published
    var items: [NoteListItemViewModel] = []
    
    var service: NotesService = NotesService()
    
    init(id: Int) {
        self.id = id
    }
    
    func onAppear(){
        service.loadNotes(with: id) { result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self.items = model.map {
                        NoteListItemViewModel(
                            text: $0.text,
                            field_id: $0.field_id,
                            id: $0.id
                        )}
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
