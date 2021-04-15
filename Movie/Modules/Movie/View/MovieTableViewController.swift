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

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupTableView()
    }

    // MARK: - Methods

    private func setupNavigation() {
        navigationItem.title = "Movies"
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
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kMovieCell, for: indexPath)
        cell.textLabel?.text = "Movie name"
        return cell
    }

}
