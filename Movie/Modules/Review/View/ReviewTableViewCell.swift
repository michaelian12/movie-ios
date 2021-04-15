//
//  ReviewTableViewCell.swift
//  Movie
//
//  Created by Michael Agustian on 15/04/21.
//

import UIKit

final class ReviewTableViewCell: UITableViewCell {

    // MARK: - UI Properties

    private lazy var authorNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Author"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "Content"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initialisation

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    private func setupViews() {
        addSubview(authorNameLabel)
        addSubview(contentLabel)

        addConstraintsWithFormat("H:|-16-[v0]-16-|", views: authorNameLabel)
        addConstraintsWithFormat("H:|-16-[v0]-16-|", views: contentLabel)
        addConstraintsWithFormat("V:|-16-[v0]-[v1]-16-|", views: authorNameLabel, contentLabel)
    }

    func setReview(_ review: ReviewModel) {
        authorNameLabel.text = review.authorName
        contentLabel.text = review.content
    }

}
