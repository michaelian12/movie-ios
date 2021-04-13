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

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigation()
        setupTableView()
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
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kGenreCell, for: indexPath)
        cell.textLabel?.text = "Genre Name"
        return cell
    }

}
