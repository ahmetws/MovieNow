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

    let window: UIWindow?
    let apiEngine: APIEngine!
    var rootViewController: UINavigationController!
    
    init(window: UIWindow?) {
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
        let viewModel = NowPlayingViewModel(apiEngine: apiEngine)
        let viewController = NowPlayingViewController(viewModel: viewModel)
        return viewController
    }
}
