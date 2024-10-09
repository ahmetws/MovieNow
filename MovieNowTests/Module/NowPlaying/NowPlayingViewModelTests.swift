//
//  NowPlayingViewModelTests.swift
//  MovieNowTests
//
//  Created by Ahmet Yalcinkaya on 08/10/2024.
//

import Quick
import Nimble
@testable import MovieNow

final class NowPlayingViewModelTests: QuickSpec {

    override class func spec() {
        describe("NowPlayingViewModel") {
            it("has initial parameters") {
                let useCase = NowPlayingUseCase(
                    repository: NowPlayingRepository(
                        service: NowPlayingService(
                            dependencies: MockDependencies())))
                let viewModel = NowPlayingViewModel(useCase: useCase)
                expect(viewModel.title).to(equal("MovieNow"))
                expect(viewModel.viewAccesibilityLabel).to(equal("nowPlayingScreen"))
            }
        }
    }
}
