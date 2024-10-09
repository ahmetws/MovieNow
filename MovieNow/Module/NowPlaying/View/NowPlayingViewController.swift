//
//  NowPlayingViewController.swift
//  MovieNow
//
//  Created by Ahmet Yalcinkaya on 08/10/2024.
//

import UIKit

class NowPlayingViewController: UITableViewController {
    private var viewModel: NowPlayingViewModel!

    convenience init(viewModel: NowPlayingViewModel) {
        self.init(style: .insetGrouped)
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        prepareUI()
        getMovies()
    }

    private func prepareUI() {
        title = viewModel.title
        view.accessibilityLabel = viewModel.viewAccesibilityLabel
        view.backgroundColor = .systemGray6
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(MovieCell.self)
    }

    private func getMovies() {
        viewModel.getMovies { [weak self] in
            Task { @MainActor in
                self?.reloadData()
            }
        }
    }

    private func reloadData() {
        tableView.reloadData()
    }
}

extension NowPlayingViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        let movie = viewModel.movies[indexPath.row]
        cell.setup(with: movie)
        return cell
    }
}
