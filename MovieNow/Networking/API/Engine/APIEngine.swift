//
//  APIEngine.swift
//  MovieNow
//
//  Created by Ahmet Yalcinkaya on 08/10/2024.
//

import Foundation
import PromiseKit

class APIEngine: APIEngineProtocol {

    var urlSession: URLSessionProtocol

    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }

    func get<T: Codable>(url: URL) -> Promise<T> {
        return Promise { seal in
            let request = URLRequest(url: url)
            urlSession.dataTask(with: request) { data, response, error in
                if let error = error {
                    seal.reject(error)
                } else if let data = data,
                          let response = try? JSONDecoder().decode(T.self, from: data) {
                    seal.fulfill(response)
                } else {
                    seal.reject(APIError.invalidResponse)
                }
            }
            .resume()
        }
    }
}
