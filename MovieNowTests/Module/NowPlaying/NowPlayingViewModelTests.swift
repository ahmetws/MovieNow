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
                let viewModel = NowPlayingViewModel()
                expect(viewModel.getTitle()).to(equal("MovieNow"))
            }
        }
    }
}
