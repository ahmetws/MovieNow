//
//  NowPlayingResponse.swift
//  MovieNow
//
//  Created by Ahmet Yalcinkaya on 08/10/2024.
//

import Foundation

struct NowPlayingResponse: Codable {
    var results: [MovieDataModel]
}
