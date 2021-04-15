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
        setupTableView()
        presenter.getMovies(withGenreId: presenter.genre.id)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }

    // MARK: - Methods

    private func setupNavigation() {
        let genreName = presenter.genre.name
        navigationItem.title = genreName.lowercased().contains("movie") ? genreName : "\(genreName) Movies"
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }

    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kMovieCell)
        tableView.backgroundColor = .systemBackground
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

// MARK: - Delegate

extension MovieTableViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let genre = presenter.genres[indexPath.row]
//        let movieUseCase = Injection.init().provideMovie()
//        let moviePresenter = MoviePresenter(genre: genre, useCase: movieUseCase)
//        let movieTableViewController = MovieTableViewController(presenter: moviePresenter)
//        moviePresenter.setView(movieTableViewController)
        let movie = presenter.movies[indexPath.row]
        navigationController?.pushViewController(MovieViewController(movie: movie), animated: true)
    }

}
