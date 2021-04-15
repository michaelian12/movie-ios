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
    private var presenter: ReviewPresenterProtocol

    // MARK: - Initialisation

    init(presenter: ReviewPresenterProtocol) {
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
        presenter.getReviews(withMovieId: presenter.movieId)
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
        return presenter.reviews.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let _cell = tableView.dequeueReusableCell(withIdentifier: kReviewCell, for: indexPath) as? ReviewTableViewCell else {
            return UITableViewCell()
        }

        let _review = presenter.reviews[indexPath.row]
        _cell.setReview(_review)
        return _cell
    }

}
