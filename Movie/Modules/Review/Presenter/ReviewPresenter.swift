//
//  ReviewPresenter.swift
//  Movie
//
//  Created by Michael Agustian on 15/04/21.
//

import Foundation

protocol ReviewPresenterProtocol: AnyObject {
    var reviews: [ReviewModel] { get }
    func getReviews()
}

final class ReviewPresenter {

    // MARK: - Properties

    var reviews: [ReviewModel] = []

}

extension ReviewPresenter: ReviewPresenterProtocol {

    func getReviews() {
        let _review = ReviewModel(id: "1", authorName: "Bambang", content: "Bagus!")
        reviews.append(_review)
    }

}
