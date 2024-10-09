//
//  Movie.swift
//  MovieNow
//
//  Created by Ahmet Yalcinkaya on 09/10/2024.
//

import Foundation

struct Movie: Codable {
    var title: String
    var overview: String
    var posterURL: URL
}
