//
//  ReviewTableViewController.swift
//  Movie
//
//  Created by Michael Agustian on 15/04/21.
//

import UIKit

final class ReviewTableViewController: UITableViewController {

    // MARK: - Properties

    private let kReviewCell = "reviewCell"

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }

    // MARK: - Methods

    private func setupTableView() {
        tableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: kReviewCell)
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = false
    }

    private func setupNavigation() {
        navigationItem.title = "Reviews"
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }

}

// MARK: - Data Source

extension ReviewTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let _cell = tableView.dequeueReusableCell(withIdentifier: kReviewCell, for: indexPath) as? ReviewTableViewCell else {
            return UITableViewCell()
        }

        let _review = ReviewModel(id: "1", authorName: "Bambang", content: "Bagus!")
        _cell.setReview(_review)
        return _cell
    }

}
