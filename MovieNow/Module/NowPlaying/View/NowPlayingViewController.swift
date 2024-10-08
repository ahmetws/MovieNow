//
//  NowPlayingViewController.swift
//  MovieNow
//
//  Created by Ahmet Yalcinkaya on 08/10/2024.
//

import UIKit

class NowPlayingViewController: UITableViewController {

    var viewModel: NowPlayingViewModel!

    convenience init(viewModel: NowPlayingViewModel) {
        self.init(style: .insetGrouped)
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        prepareUI()
    }

    private func prepareUI() {
        title = viewModel.getTitle()
        view.backgroundColor = .systemGray6
    }
}
