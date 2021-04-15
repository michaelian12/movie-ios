//
//  MovieViewController.swift
//  Movie
//
//  Created by Michael Agustian on 15/04/21.
//

import UIKit
import SDWebImage

final class MovieViewController: UIViewController {

    // MARK: - UI Properties

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

    // MARK: - Properties

    private let movie: MovieModel

    // MARK: - Initialisation

    init(movie: MovieModel) {
        self.movie = movie
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
        navigationItem.title = movie.title
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }

    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(posterImageView)
        view.addSubview(overviewLabel)

        NSLayoutConstraint.activate([
            posterImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 9/16),
            posterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            posterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            overviewLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            overviewLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            overviewLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 16),
        ])
    }

    private func setMovieDetail() {
        let posterURL = URL(string: "\(API.imageUrl)/w780\(movie.backdropPath)")
        posterImageView.sd_setImage(with: posterURL)
        overviewLabel.text = movie.overview
    }

}
