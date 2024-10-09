//
//  MockNowPlayingUseCase.swift
//  MovieNowTests
//
//  Created by Ahmet Yalcinkaya on 09/10/2024.
//

import PromiseKit
@testable import MovieNow

class MockNowPlayingUseCase: NowPlayingUseCaseType {
    var executeCalled = false
    var executeResponse: [Movie]?
    func execute() -> Promise<[Movie]> {
        executeCalled = true
        if let response = executeResponse {
            return .value(response)
        }
        return Promise.init(error: MockError.failure)
    }

    var searchCalled = false
    var searchText: String?
    func search(text: String,
                in movies: [Movie]) -> [Movie] {
        searchCalled = true
        searchText = text
        return []
    }
}
