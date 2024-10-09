//
//  NowPlayingViewModel.swift
//  MovieNow
//
//  Created by Ahmet Yalcinkaya on 08/10/2024.
//

import Foundation
import PromiseKit
import Combine
import OSLog

class NowPlayingViewModel {

    @Published public var isLoading: Bool = false
    @Published public var movies: [MovieDataModel] = []
    public var title: String { "MovieNow" }
    public var viewAccesibilityLabel: String { "nowPlayingScreen" }
    private var useCase: NowPlayingUseCaseType
    private var logger = Logger()

    init(useCase: NowPlayingUseCaseType) {
        self.useCase = useCase
    }

    public func getMovies() {
        firstly {
            self.isLoading = true
            return useCase.execute()
        }
        .done { movies in
            self.movies = movies
        }
        .ensure {
            self.isLoading = false
        }
        .catch { error in
            self.logger.debug("\(error.localizedDescription)")
        }
    }
}
