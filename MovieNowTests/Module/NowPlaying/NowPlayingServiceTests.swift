//
//  NowPlayingServiceTests.swift
//  MovieNowTests
//
//  Created by Ahmet Yalcinkaya on 09/10/2024.
//

import Quick
import Nimble
import PromiseKit
@testable import MovieNow

final class NowPlayingServiceTests: QuickSpec {

    override class func spec() {
        describe("NowPlayingService") {
            var mockAPIEngine: MockAPIEngine<NowPlayingResponse>!
            var mockDependencies: MockDependencies!

            beforeEach {
                mockAPIEngine = MockAPIEngine()
                mockDependencies = MockDependencies(apiEngine: mockAPIEngine)
            }

            context("when API Engine success") {
                it("can fetch movies") {
                    mockAPIEngine.response = NowPlayingResponse(results: [])
                    let service = NowPlayingService(dependencies: mockDependencies)

                    waitUntil { done in
                        service.performFetchNowPlaying()
                            .done { movies in
                                expect(mockAPIEngine.getCalled).to(beTrue())
                            }
                            .catch { _ in
                                fail("Should not throw")
                            }
                            .finally {
                                done()
                            }
                    }
                }
            }

            context("when API Engine fails") {
                it("should throw error") {
                    mockAPIEngine.response = nil
                    let service = NowPlayingService(dependencies: mockDependencies)

                    waitUntil { done in
                        service.performFetchNowPlaying()
                            .done { movies in
                                fail("Should not return data")
                            }
                            .catch { _ in
                                expect(true).to(beTrue())
                            }
                            .finally {
                                done()
                            }
                    }
                }
            }
        }
    }
}
