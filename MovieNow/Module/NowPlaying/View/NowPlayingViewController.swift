//
//  NowPlayingViewController.swift
//  MovieNow
//
//  Created by Ahmet Yalcinkaya on 08/10/2024.
//

import UIKit
import Combine

class NowPlayingViewController: UITableViewController {
    private enum Constant {
        static let padding: CGFloat = 16
    }

    private var cancellables = Set<AnyCancellable>()
    private var viewModel: NowPlayingViewModel!

    private let loadingView: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.style = .medium
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
        return spinner
    }()

    convenience init(viewModel: NowPlayingViewModel) {
        self.init(style: .insetGrouped)
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        prepareUI()
        prepareBindings()
        getMovies()
    }

    private func prepareUI() {
        title = viewModel.title
        view.accessibilityLabel = viewModel.viewAccesibilityLabel
        view.backgroundColor = .systemGray6
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(MovieCell.self)

        tableView.addSubview(loadingView)

        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            loadingView.topAnchor.constraint(equalTo: tableView.topAnchor, constant: Constant.padding)
        ])
    }

    private func prepareBindings() {
        viewModel.$isLoading
            .sink { [weak self] loading in
                self?.displayLoading(loading)
                self?.reloadData()
            }
            .store(in: &cancellables)

        viewModel.$movies
            .sink { [weak self] _ in
                self?.reloadData()
            }
            .store(in: &cancellables)

    }

    private func getMovies() {
        viewModel.getMovies()
    }

    private func reloadData() {
        tableView.reloadData()
    }

    private func displayLoading(_ isLoading: Bool) {
        loadingView.isHidden = !isLoading
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
