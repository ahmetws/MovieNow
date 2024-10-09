//
//  NowPlayingViewModel.swift
//  MovieNow
//
//  Created by Ahmet Yalcinkaya on 08/10/2024.
//

import Foundation
import PromiseKit

class NowPlayingViewModel {

    var isLoading: Bool = false
    var title: String { "MovieNow" }
    var viewAccesibilityLabel: String { "nowPlayingScreen" }
    var movies: [MovieDataModel] = []
    var useCase: NowPlayingUseCaseType

    init(apiEngine: APIEngineProtocol) {
        self.useCase = NowPlayingUseCase(
            repository: NowPlayingRepository(
                service: NowPlayingService(
                    apiEngine: apiEngine)))
    }

    func getMovies(completion: @escaping () -> Void) {
        firstly {
            self.isLoading = true
            return useCase.execute()
        }
        .done { movies in
            self.movies = movies
        }
        .ensure {
            self.isLoading = false
            completion()
        }
        .catch { error in
            print(error)
        }
    }
}
