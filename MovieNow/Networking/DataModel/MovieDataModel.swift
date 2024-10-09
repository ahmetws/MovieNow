//
//  MovieDataModel.swift
//  MovieNow
//
//  Created by Ahmet Yalcinkaya on 08/10/2024.
//

import Foundation

struct MovieDataModel: Codable {
    var movieId: Int
    var title: String
    var overview: String
    var posterPath: String

    private enum CodingKeys : String, CodingKey {
        case movieId = "id", title, overview, posterPath = "poster_path"
    }
}

extension MovieDataModel {
    func getPosterUrl() -> URL? {
        return URL(string: "\(AppConstants.API.BaseImagePath)\(posterPath)")
    }
}

extension MovieDataModel {
    func toMovie() -> Movie? {
        if let posterUrl = getPosterUrl() {
            return Movie(title: title, overview: overview, posterURL: posterUrl)
        }
        return nil
    }
}
