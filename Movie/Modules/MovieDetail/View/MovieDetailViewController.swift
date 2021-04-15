//
//  MovieDetailViewController.swift
//  Movie
//
//  Created by Michael Agustian on 15/04/21.
//

import UIKit
import SDWebImage

final class MovieDetailViewController: UIViewController {

    // MARK: - UI Properties

    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        button.translatesAutoresizingMaskIntoConstraints = false
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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }

    // MARK: - Methods

    private func setupNavigation() {
        navigationItem.title = presenter.movie.title
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }

    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(posterImageView)
        view.addSubview(overviewLabel)
        view.addSubview(seeReviewsButton)

        NSLayoutConstraint.activate([
            posterImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 9/16),
            posterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            posterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            overviewLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            overviewLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            overviewLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 16),
            seeReviewsButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            seeReviewsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            seeReviewsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }

    private func setMovieDetail() {
        let _movie = presenter.movie
        let _posterURL = URL(string: "\(API.imageUrl)/w780\(_movie.backdropPath)")
        posterImageView.sd_setImage(with: _posterURL)
        overviewLabel.text = _movie.overview
    }

}