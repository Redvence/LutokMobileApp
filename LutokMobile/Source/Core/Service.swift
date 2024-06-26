//
//  Service.swift
//  LutokMobile
//
//  Created by Maria Vanurina on 29.03.2024.
//

import Foundation

enum CustomError: Error {
    case badServerResponse
}


class Service {
    
    var baseUrl: String = "http://localhost:3000/api/v1/"
    
    static var token: String = ""
    
    func getRequest<D: Decodable>(
        endpoint: String,
        callback: @escaping (Result<D, Error>) -> (Void)
    ) {
        // MARK: - Endpoint
        var request = URLRequest(url: URL(string: "\(self.baseUrl)\(endpoint)")!)
        // MARK: - Method
        request.httpMethod = "GET"
        // MARK: - Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        NSLog("[Service] - Requesting \(request.url?.absoluteURL.absoluteString ?? "Unknown") (\(request.httpMethod!))")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                // got error
                callback(.failure(error))
            } else if let data = data {
                print(response)
                print("\(D.self)")
                // MARK: - response
                guard let model = try? JSONDecoder().decode(D.self, from: data) else {
                    NSLog("[Service] - Decoding failed. Trying to decode \(D.self). Got \n\(String(data: data, encoding: .utf8) ?? "nil")")
                    callback(.failure(CustomError.badServerResponse))
                    return
                }
                
                callback(.success(model))
                
            } else {
                NSLog("[Service] - No data from endpoint \(endpoint)")
                callback(.failure(CustomError.badServerResponse))
            }
        }
        
        task.resume()
    }
    
    func getRequest(
        endpoint: String,
        callback: @escaping (Result<String, Error>) -> (Void)
    ) {
        // MARK: - Endpoint
        var request = URLRequest(url: URL(string: "\(self.baseUrl)\(endpoint)")!)
        // MARK: - Method
        request.httpMethod = "GET"
        // MARK: - Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                // got error
                callback(.failure(error))
            } else if let data = data {
                
                // MARK: - response
                guard let model = String(data: data, encoding: .utf8) else {
                    callback(.failure(CustomError.badServerResponse))
                    return
                }
                
                callback(.success(model))
                
            } else {
                // no data
                callback(.failure(CustomError.badServerResponse))
            }
        }
        
        task.resume()
    }
    
    // Server post request
    func postRequest<D: Decodable>(
        endpoint: String,
        body: [String: Any],
        callback: @escaping (Result<D, Error>) -> (Void)
        //callback: @escaping (String) -> Void)
    ){
        //self.token = ""
        
        // MARK: - Endpoint
        var request = URLRequest(url: URL(string: "\(self.baseUrl)\(endpoint)")!)
        // MARK: - Method
        request.httpMethod = "POST"
        // MARK: - Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // MARK: - Body
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                // got error
                callback(.failure(error))
            } else if let data = data {
                
                // MARK: - response
                
                guard let model = try? JSONDecoder().decode(D.self, from: data) else {
                    callback(.failure(CustomError.badServerResponse))
                    return
                }
                
                callback(.success(model))
                
            } else {
                // no data
                callback(.failure(CustomError.badServerResponse))
            }
        }
        
        task.resume()
    }
    
    func postRequest(
        endpoint: String,
        body: [String: Any],
        callback: @escaping (Result<Void, Error>) -> (Void)
        //callback: @escaping (String) -> Void)
    ){
        //self.token = ""
        
        // MARK: - Endpoint
        var request = URLRequest(url: URL(string: "\(self.baseUrl)\(endpoint)")!)
        // MARK: - Method
        request.httpMethod = "POST"
        // MARK: - Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // MARK: - Body
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                // got error
                callback(.failure(error))
            } else {
                guard let response = response as? HTTPURLResponse else {
                    callback(.failure(CustomError.badServerResponse))
                    return
                }
                
                switch response.statusCode {
                case 200...299:
                    callback(.success(()))
                default:
                    callback(.failure(CustomError.badServerResponse))
                }
                
            }
        }
        
        task.resume()
    }
    
}
