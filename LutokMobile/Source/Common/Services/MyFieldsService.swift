//
//  MyFieldsService.swift
//  LutokMobile
//
//  Created by Maria Vanurina on 30.03.2024.
//

import Foundation

struct FieldsResponse: Decodable, Identifiable {
    let id: Int
    let title: String
    let place: String

}

final class MyFieldsService: Service {
    func createField(
        title: String,
        place: String,
        user_id: Int,
        callback: @escaping (Result<Void, Error>) -> (Void)
    ) {
        let endPoint = "fields#create"
        let body: [String: Any] = [
            "field": [
                "title": title,
                "place": place,
                "user_id": user_id
            ]]
        postRequest(endpoint: endPoint, body: body, callback: callback)
    }
    
    func loadFields(
        callback: @escaping (Result<[FieldsResponse], Error>) -> (Void)
    ) {
        let endPoint = "fields"
        getRequest(endpoint: endPoint, callback: callback)
    }
}
