//
//  NowPlayingUseCase.swift
//  MovieNow
//
//  Created by Ahmet Yalcinkaya on 08/10/2024.
//

import Foundation
import PromiseKit

protocol NowPlayingUseCaseType {
    func execute() -> Promise<[Movie]>
    func search(text: String, in movies: [Movie]) -> [Movie]
}

class NowPlayingUseCase: NowPlayingUseCaseType {
    private let repository: NowPlayingRepositoryType

    init(repository: NowPlayingRepositoryType) {
        self.repository = repository
    }

    func execute() -> Promise<[Movie]> {
        repository.fetchNowPlaying().map { movieList in
            movieList.compactMap { $0.toMovie() }
        }
    }

    func search(text: String, in movies: [Movie]) -> [Movie] {
        if text.isEmpty {
            return movies
        }

        return movies.filter {
            $0.title.range(of: text, options: .caseInsensitive) != nil
        }
    }
}
