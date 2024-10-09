//
//  NowPlayingUseCaseTests.swift
//  MovieNowTests
//
//  Created by Ahmet Yalcinkaya on 09/10/2024.
//

import Quick
import Nimble
import PromiseKit
@testable import MovieNow

final class NowPlayingUseCaseTests: QuickSpec {

    override class func spec() {
        describe("NowPlayingUseCase") {
            var mockRepository: MockNowPlayingRepository!

            beforeEach {
                mockRepository = MockNowPlayingRepository()
            }

            context("when repository success") {
                it("can fetch movies") {
                    mockRepository.nowPlayingResponse = []
                    let useCase = NowPlayingUseCase(repository: mockRepository)

                    waitUntil { done in
                        useCase.execute()
                            .done { movies in
                                expect(mockRepository.fetchNowPlayingCalled).to(beTrue())
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

            context("when repository fails") {
                it("should throw error") {
                    mockRepository.nowPlayingResponse = nil
                    let useCase = NowPlayingUseCase(repository: mockRepository)

                    waitUntil { done in
                        useCase.execute()
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
