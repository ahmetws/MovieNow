//
//  AppCoordinator.swift
//  MovieNow
//
//  Created by Ahmet Yalcinkaya on 08/10/2024.
//

import UIKit

protocol AppCoordinatorProtocol {
    func start()
}

class AppCoordinator: AppCoordinatorProtocol {

    var rootViewController: UINavigationController!
    private let window: UIWindow?
    private let apiEngine: APIEngine!
    private let dependencies: Dependencies

    init(dependencies: Dependencies,
         window: UIWindow?) {
        self.dependencies = dependencies
        self.window = window
        apiEngine = APIEngine()
    }

    func start() {
        guard let window = window else { return }

        rootViewController = UINavigationController(rootViewController: getNowPlayingController())
        rootViewController.navigationBar.prefersLargeTitles = true
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }

    private func getNowPlayingController() -> NowPlayingViewController {
        let useCase = NowPlayingUseCase(
            repository: NowPlayingRepository(
                service: NowPlayingService(
                    dependencies: dependencies)))
        let viewModel = NowPlayingViewModel(useCase: useCase)
        let viewController = NowPlayingViewController(viewModel: viewModel)
        return viewController
    }
}
