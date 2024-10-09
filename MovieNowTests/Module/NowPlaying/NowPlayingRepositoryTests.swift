//
//  NowPlayingRepositoryTests.swift
//  MovieNowTests
//
//  Created by Ahmet Yalcinkaya on 09/10/2024.
//

import Quick
import Nimble
import PromiseKit
@testable import MovieNow

final class NowPlayingRepositoryTests: QuickSpec {

    override class func spec() {
        describe("NowPlayingRepository") {
            var mockService: MockNowPlayingService!

            beforeEach {
                mockService = MockNowPlayingService()
            }

            context("when API success") {
                it("can fetch movies") {
                    mockService.nowPlayingResponse = NowPlayingResponse(results: [])
                    let repository = NowPlayingRepository(service: mockService)

                    waitUntil { done in
                        repository.fetchNowPlaying()
                            .done { movies in
                                expect(mockService.performFetchNowPlayingCalled).to(beTrue())
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

            context("when API fails") {
                it("should throw error") {
                    mockService.nowPlayingResponse = nil
                    let repository = NowPlayingRepository(service: mockService)

                    waitUntil { done in
                        repository.fetchNowPlaying()
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
