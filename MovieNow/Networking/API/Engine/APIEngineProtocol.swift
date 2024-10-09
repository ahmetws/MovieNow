//
//  APIEngineProtocol.swift
//  MovieNow
//
//  Created by Ahmet Yalcinkaya on 08/10/2024.
//

import Foundation
import PromiseKit

public protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }

public protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    public func dataTask(with request: URLRequest,
                         completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        return (dataTask(with: request,
                         completionHandler: completionHandler) as URLSessionDataTask) as URLSessionDataTaskProtocol
    }
}

public protocol APIEngineProtocol {
    var urlSession: URLSessionProtocol { get set }

    func get<T: Codable>(url: URL) -> Promise<T>
}
