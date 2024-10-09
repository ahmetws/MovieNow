//
//  APIError.swift
//  MovieNow
//
//  Created by Ahmet Yalcinkaya on 08/10/2024.
//

import Foundation

enum APIError: String, Error {
    case invalidURL = "The URL is invalid"
    case invalidData = "The data is invalid"
    case invalidResponse = "The response is invalid"
    case failure = "Something went wrong!"
}
