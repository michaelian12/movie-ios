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
    func getReviews(withMovieId movieId: Int)
}

final class ReviewPresenter {

    // MARK: - Properties

    private let reviewUseCase: ReviewUseCase
    private weak var view: ReviewTableViewController?
    let movieId: Int
    var reviews: [ReviewModel] = []
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
        reviewUseCase.getReviews(withMovieId: movieId) { [weak self] result in
            switch result {
            case .success(let reviews):
                self?.reviews = reviews
                self?.view?.tableView.reloadData()
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
        }
    }

}
