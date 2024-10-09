//
//  NowPlayingViewModelTests.swift
//  MovieNowTests
//
//  Created by Ahmet Yalcinkaya on 08/10/2024.
//

import Foundation
import Quick
import Nimble
import PromiseKit
@testable import MovieNow

final class NowPlayingViewModelTests: QuickSpec {

    override class func spec() {
        describe("NowPlayingViewModel") {
            var mockUseCase: MockNowPlayingUseCase!

            beforeEach {
                mockUseCase = MockNowPlayingUseCase()
            }

            it("has initial parameters") {
                let viewModel = NowPlayingViewModel(useCase: mockUseCase)
                expect(viewModel.title).to(equal("MovieNow"))
                expect(viewModel.viewAccesibilityLabel).to(equal("nowPlayingScreen"))
                expect(viewModel.searchBarAccesibilityLabel).to(equal("searchBarAccesibilityLabel"))
            }

            context("when use case success") {
                it("can get movies") {
                    mockUseCase.executeResponse = [
                        Movie(title: "", overview: "", posterURL: URL(string: "http://test")!)
                    ]
                    let viewModel = NowPlayingViewModel(useCase: mockUseCase)

                    viewModel.getMovies()
                    expect(mockUseCase.executeCalled).to(beTrue())
                    expect(viewModel.isLoading).toEventually(beFalse())
                    expect(viewModel.filteredMovies).toEventuallyNot(beEmpty())
                }
            }

            context("when use case fails") {
                it("can not get movies") {
                    mockUseCase.executeResponse = nil
                    let viewModel = NowPlayingViewModel(useCase: mockUseCase)

                    viewModel.getMovies()
                    expect(mockUseCase.executeCalled).to(beTrue())
                    expect(viewModel.isLoading).toEventually(beFalse())
                    expect(viewModel.filteredMovies).toEventually(beEmpty())
                }
            }

            context("when searched") {
                it("filter movies accordingly") {
                    mockUseCase.executeResponse = [
                        Movie(title: "always", overview: "", posterURL: URL(string: "http://test")!),
                        Movie(title: "all", overview: "", posterURL: URL(string: "http://test")!)
                    ]
                    let viewModel = NowPlayingViewModel(useCase: mockUseCase)

                    let searchText = "ways"
                    viewModel.search(text: searchText)
                    expect(mockUseCase.searchCalled).to(beTrue())
                    expect(mockUseCase.searchText).to(equal(searchText))
                }
            }

        }
    }
}
