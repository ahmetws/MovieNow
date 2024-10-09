//
//  MockAPIEngine.swift
//  MovieNow
//
//  Created by Ahmet Yalcinkaya on 09/10/2024.
//

import Foundation
import PromiseKit
@testable import MovieNow

class MockAPIEngine<U: Codable>: APIEngineProtocol {
    var urlSession: URLSessionProtocol = URLSession.shared

    var getCalled = false
    var response: U?

    func get<T>(url: URL) -> Promise<T> where T: Codable {
        getCalled = true

        if let response = response {
            return .value(response as! T)
        }
        return Promise.init(error: MockError.failure)
    }
}
