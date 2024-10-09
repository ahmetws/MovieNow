//
//  MockDependencies.swift
//  MovieNowTests
//
//  Created by Ahmet Yalcinkaya on 09/10/2024.
//

import Foundation
@testable import MovieNow

class MockDependencies: Dependencies {
    var apiEngine: APIEngineProtocol

    init(apiEngine: APIEngineProtocol = MockAPIEngine<NowPlayingResponse>()) {
        self.apiEngine = apiEngine
    }
}
