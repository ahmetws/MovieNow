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
    let window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
    }

    func start() {
        guard let window = window else { return }

        rootViewController = UINavigationController(rootViewController: getNowPlayingController())
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }

    private func getNowPlayingController() -> NowPlayingViewController {
        let viewModel = NowPlayingViewModel()
        let viewController = NowPlayingViewController(viewModel: viewModel)
        return viewController
    }
}
