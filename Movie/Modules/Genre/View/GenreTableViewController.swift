//
//  GenreTableViewController.swift
//  Movie
//
//  Created by Michael Agustian on 13/04/21.
//

import UIKit


final class GenreTableViewController: UITableViewController {

    // MARK: - Properties

    private let kGenreCell = "genreCell"
    private let presenter: GenrePresenter

    // MARK: - Initialisation

    init(presenter: GenrePresenter) {
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
        presenter.getGenres()
    }

    // MARK: - Methods

    private func setupNavigation() {
        navigationItem.title = "Genres"
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }

    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kGenreCell)
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = false
        tableView.separatorStyle = .singleLine
    }

}

// MARK: - Data Source

extension GenreTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.genres.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kGenreCell, for: indexPath)
        cell.textLabel?.text = presenter.genres[indexPath.row].name
        return cell
    }

}