//
//  NowPlayingService.swift
//  MovieNow
//
//  Created by Ahmet Yalcinkaya on 09/10/2024.
//

import Foundation
import PromiseKit

protocol NowPlayingServiceType {
    func performFetchNowPlaying() -> Promise<NowPlayingResponse>
}

class NowPlayingService: NowPlayingServiceType {
    var apiEngine: APIEngineProtocol!

    init(apiEngine: APIEngineProtocol) {
        self.apiEngine = apiEngine
    }

    func performFetchNowPlaying() -> Promise<NowPlayingResponse> {
        guard let url = URL(string: APIEndPoint.nowPlaying.buildUrl()) else {
            return Promise(error: APIError.invalidURL)
        }

        return apiEngine.get(url: url)
    }
}
