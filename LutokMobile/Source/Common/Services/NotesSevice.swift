//
//  NotesSevice.swift
//  LutokMobile
//
//  Created by Maria Vanurina on 25.06.2024.
//

import Foundation

struct NotesResponse: Decodable, Identifiable {
    let id: Int
    let text: String
    let field_id: Int

}

final class NotesService: Service {
    func createNote(
        text: String,
        field_id: Int,
        callback: @escaping (Result<Void, Error>) -> (Void)
    ) {
        let endPoint = "fields/\(field_id)/notes#create"
        let body: [String: Any] = [
            "note": [
                "text": text,
                "field_id": field_id,
            ]]
        postRequest(endpoint: endPoint, body: body, callback: callback)
    }
    
    func loadNotes(
        with id: Int,
        callback: @escaping (Result<[NotesResponse], Error>) -> (Void)
    ) {
        let endPoint = "fields/\(id)/notes"
        getRequest(endpoint: endPoint, callback: callback)
    }
}
