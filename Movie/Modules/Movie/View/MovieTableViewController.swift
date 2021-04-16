//
//  MovieTableViewController.swift
//  Movie
//
//  Created by Michael Agustian on 15/04/21.
//

import UIKit
import MJRefresh

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
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kMovieCell)
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .singleLine

        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headerRefresh))
        header.lastUpdatedTimeLabel?.isHidden = true
        tableView.mj_header = header

        let footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(footerRefresh))
        footer.setTitle("", for: .noMoreData)
        tableView.mj_footer = footer
    }

    func endRefreshing() {
        tableView.mj_header?.endRefreshing()
        tableView.mj_footer?.endRefreshing()
        tableView.reloadData()
    }

    // MARK: - Action Methods

    @objc private func headerRefresh() {
        presenter.page = 1
        presenter.getMovies(withGenreId: presenter.genre.id)
    }

    @objc private func footerRefresh() {
        presenter.page += 1
        presenter.getMovies(withGenreId: presenter.genre.id)
    }

}

// MARK: - Data Source

extension MovieTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let _cell = tableView.dequeueReusableCell(withIdentifier: kMovieCell, for: indexPath)
        _cell.textLabel?.text = presenter.movies[indexPath.row].title
        return _cell
    }

}

// MARK: - Delegate

extension MovieTableViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let _movie = presenter.movies[indexPath.row]
        let _movieDetailUseCase = Injection.init().provideMovieDetail()
        let _movieDetailPresenter = MovieDetailPresenter(movie: _movie, useCase: _movieDetailUseCase)
        let _movieDetailViewController = MovieDetailViewController(presenter: _movieDetailPresenter)
        _movieDetailPresenter.setView(_movieDetailViewController)
        navigationController?.pushViewController(_movieDetailViewController, animated: true)
    }

}
