//
//  NowPlayingViewController.swift
//  MovieNow
//
//  Created by Ahmet Yalcinkaya on 08/10/2024.
//

import UIKit
import Combine

class NowPlayingViewController: UIViewController {
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

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(MovieCell.self)
        return tableView
    }()

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.barTintColor = .systemGray6
        return searchBar
    }()

    convenience init(viewModel: NowPlayingViewModel) {
        self.init()
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
        tableView.dataSource = self
        tableView.delegate = self

        searchBar.delegate = self
        searchBar.accessibilityLabel = viewModel.searchBarAccesibilityLabel

        [searchBar, tableView, loadingView].forEach { view.addSubview($0) }

        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            loadingView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constant.padding),

            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.padding),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.padding),

            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func prepareBindings() {
        viewModel.$isLoading
            .sink { [weak self] loading in
                self?.displayLoading(loading)
                self?.reloadData()
            }
            .store(in: &cancellables)

        viewModel.$filteredMovies
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

extension NowPlayingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filteredMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        let movie = viewModel.filteredMovies[indexPath.row]
        cell.setup(with: movie)
        return cell
    }
}

extension NowPlayingViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(text: searchText)
        tableView.reloadData()
    }
}
