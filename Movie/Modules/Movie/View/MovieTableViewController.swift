//
//  MovieTableViewController.swift
//  Movie
//
//  Created by Michael Agustian on 15/04/21.
//

import UIKit

final class MovieTableViewController: UITableViewController {

    // MARK: - Properties

    private let kMovieCell = "movieCell"
    private var presenter: MoviePresenterProtocol

    // MARK: - Initialisation

    init(presenter: MoviePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupTableView()
        presenter.getMovies(withGenreId: presenter.genre.id)
    }

    // MARK: - Methods

    private func setupNavigation() {
        navigationItem.title = presenter.genre.name
    }

    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kMovieCell)
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = false
        tableView.separatorStyle = .singleLine
    }

}

// MARK: - Data Source

extension MovieTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kMovieCell, for: indexPath)
        cell.textLabel?.text = presenter.movies[indexPath.row].title
        return cell
    }

}
