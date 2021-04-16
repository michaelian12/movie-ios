//
//  MovieDetailViewController.swift
//  Movie
//
//  Created by Michael Agustian on 15/04/21.
//

import UIKit
import SDWebImage
import youtube_ios_player_helper

final class MovieDetailViewController: UIViewController {

    // MARK: - UI Properties

    private lazy var youTubePlayerView: YTPlayerView = {
        let playerView = YTPlayerView()
        playerView.translatesAutoresizingMaskIntoConstraints = false
        return playerView
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isDirectionalLockEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var seeReviewsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See Reviews", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.pushToReviewPage), for: .touchUpInside)
        return button
    }()

    // MARK: - Properties

    private let presenter: MovieDetailPresenterProtocol

    // MARK: - Initialisation

    init(presenter: MovieDetailPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setMovieDetail()
        presenter.getTrailerVideo(withMovieId: presenter.movie.id)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }

    // MARK: - Methods

    private func setupNavigation() {
        navigationItem.title = "Movie Detail"
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    private func setupViews() {
        setupScrollView()

        view.backgroundColor = .systemBackground
        view.addSubview(youTubePlayerView)
        view.addSubview(scrollView)
        view.addSubview(seeReviewsButton)

        NSLayoutConstraint.activate([
            youTubePlayerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            youTubePlayerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            youTubePlayerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            youTubePlayerView.heightAnchor.constraint(equalTo: youTubePlayerView.widthAnchor, multiplier: 9/16),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: youTubePlayerView.bottomAnchor, constant: 16),
            seeReviewsButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            seeReviewsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            seeReviewsButton.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 16),
            seeReviewsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            seeReviewsButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    private func setupScrollView() {
        setupContainerView()
        scrollView.addSubview(containerView)

        scrollView.addConstraintsWithFormat("H:|[v0]|", views: containerView)
        scrollView.addConstraintsWithFormat("V:|[v0]|", views: containerView)
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }

    private func setupContainerView() {
        containerView.addSubview(posterImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(overviewLabel)

        NSLayoutConstraint.activate([
            posterImageView.widthAnchor.constraint(equalToConstant: 100),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 3/2),
            posterImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }

    func setMovieDetail() {
        let _movie = presenter.movie
        let _posterURL = URL(string: "\(API.imageUrl)/w780\(_movie.posterPath)")
        posterImageView.sd_setImage(with: _posterURL)
        titleLabel.text = _movie.title
        overviewLabel.text = _movie.overview
        youTubePlayerView.load(withVideoId: presenter.youTubeId)
    }

    // MARK: - Action Methods

    @objc private func pushToReviewPage() {
        let _movieId = presenter.movie.id
        let _reviewUseCase = Injection.init().provideReview()
        let _reviewPresenter = ReviewPresenter(movieId: _movieId, useCase: _reviewUseCase)
        let _reviewTableViewController = ReviewTableViewController(presenter: _reviewPresenter)
        _reviewPresenter.setView(_reviewTableViewController)
        navigationController?.pushViewController(_reviewTableViewController, animated: true)
    }

}
