//
//  APIEndPoints.swift
//  MovieNow
//
//  Created by Ahmet Yalcinkaya on 08/10/2024.
//

import Foundation

enum APIEndPoint {
    case nowPlaying

    func endPoint() -> String {
        switch self {
        case .nowPlaying:
            return "movie/now_playing"
        }
    }

    func buildUrl() -> String {
        return "\(AppConstants.API.BaseURL)\(AppConstants.API.BaseAPIVersion)/\(endPoint())?api_key=\(AppConstants.API.TheMovieDBAPIKey)"
    }
}
