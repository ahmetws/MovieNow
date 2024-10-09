//
//  MockNowPlayingService.swift
//  MovieNow
//
//  Created by Ahmet Yalcinkaya on 09/10/2024.
//

import PromiseKit
@testable import MovieNow

class MockNowPlayingService: NowPlayingServiceType {
    var performFetchNowPlayingCalled = false
    var nowPlayingResponse: NowPlayingResponse?
    func performFetchNowPlaying() -> Promise<NowPlayingResponse> {
        performFetchNowPlayingCalled = true
        if let response = nowPlayingResponse {
            return .value(response)
        }
        return Promise.init(error: MockError.failure)
    }
}
