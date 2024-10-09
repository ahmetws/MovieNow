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
    typealias RequiredDependencies = APIEngineInjectable

    var dependencies: RequiredDependencies!

    init(dependencies: RequiredDependencies) {
        self.dependencies = dependencies
    }

    func performFetchNowPlaying() -> Promise<NowPlayingResponse> {
        guard let url = URL(string: APIEndPoint.nowPlaying.buildUrl()) else {
            return Promise(error: APIError.invalidURL)
        }

        return dependencies.apiEngine.get(url: url)
    }
}
