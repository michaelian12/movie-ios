//
//  ReviewTableViewController.swift
//  Movie
//
//  Created by Michael Agustian on 15/04/21.
//

import UIKit
import MJRefresh

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

        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headerRefresh))
        header.lastUpdatedTimeLabel?.isHidden = true
        tableView.mj_header = header

        let footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(footerRefresh))
        footer.setTitle("", for: .noMoreData)
        tableView.mj_footer = footer
    }

    private func setupNavigation() {
        navigationItem.title = "Reviews"
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    func endRefreshing() {
        tableView.mj_header?.endRefreshing()
        tableView.mj_footer?.endRefreshing()
        tableView.reloadData()
    }

    // MARK: - Action Methods

    @objc private func headerRefresh() {
        presenter.page = 1
        presenter.getReviews(withMovieId: presenter.movieId)
    }

    @objc private func footerRefresh() {
        presenter.page += 1
        presenter.getReviews(withMovieId: presenter.movieId)
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
