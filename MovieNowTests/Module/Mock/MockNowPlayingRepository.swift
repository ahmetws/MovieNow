//
//  MockNowPlayingRepository.swift
//  MovieNow
//
//  Created by Ahmet Yalcinkaya on 09/10/2024.
//

import PromiseKit
@testable import MovieNow

class MockNowPlayingRepository: NowPlayingRepositoryType {
    var fetchNowPlayingCalled = false
    var nowPlayingResponse: [MovieDataModel]?
    func fetchNowPlaying() -> Promise<[MovieDataModel]> {
        fetchNowPlayingCalled = true
        if let response = nowPlayingResponse {
            return .value(response)
        }
        return Promise.init(error: MockError.failure)
    }
}
