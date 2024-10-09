//
//  NowPlayingRepository.swift
//  MovieNow
//
//  Created by Ahmet Yalcinkaya on 08/10/2024.
//

import Foundation
import PromiseKit

protocol NowPlayingRepositoryType {
    func fetchNowPlaying() -> Promise<[MovieDataModel]>
}

class NowPlayingRepository: NowPlayingRepositoryType {
    var service: NowPlayingServiceType!

    init(service: NowPlayingServiceType) {
        self.service = service
    }

    func fetchNowPlaying() -> Promise<[MovieDataModel]> {
        return service.performFetchNowPlaying().map { response in
            response.results
        }
    }
}
