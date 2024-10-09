//
//  NowPlayingUseCase.swift
//  MovieNow
//
//  Created by Ahmet Yalcinkaya on 08/10/2024.
//

import Foundation
import PromiseKit

protocol NowPlayingUseCaseType {
    func execute() -> Promise<[MovieDataModel]>
}

class NowPlayingUseCase: NowPlayingUseCaseType {
    private let repository: NowPlayingRepositoryType

    init(repository: NowPlayingRepositoryType) {
        self.repository = repository
    }

    func execute() -> Promise<[MovieDataModel]> {
        repository.fetchNowPlaying()
    }
}
