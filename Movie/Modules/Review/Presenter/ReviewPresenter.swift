//
//  ReviewPresenter.swift
//  Movie
//
//  Created by Michael Agustian on 15/04/21.
//

import Foundation

protocol ReviewPresenterProtocol: AnyObject {
    var movieId: Int { get }
    var reviews: [ReviewModel] { get }
    var page: Int { get set }
    func getReviews(withMovieId movieId: Int)
}

final class ReviewPresenter {

    // MARK: - Properties

    private let reviewUseCase: ReviewUseCase
    private weak var view: ReviewTableViewController?
    let movieId: Int
    var reviews: [ReviewModel] = []
    var page: Int = 1
    var errorMessage: String = ""

    // MARK: - Initialisation

    init(movieId: Int, useCase: ReviewUseCase) {
        self.movieId = movieId
        self.reviewUseCase = useCase
    }

    // MARK: - Methods

    func setView(_ view: ReviewTableViewController) {
        self.view = view
    }

}

extension ReviewPresenter: ReviewPresenterProtocol {

    func getReviews(withMovieId movieId: Int) {
        reviewUseCase.getReviews(withMovieId: movieId, page: page) { [weak self] result in
            switch result {
            case .success(let reviews):
                if self?.page == 1 {
                    self?.reviews = reviews
                } else {
                    self?.reviews.append(contentsOf: reviews)
                }

                self?.view?.endRefreshing()
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
                self?.view?.endRefreshing()
            }
        }
    }

}
