//
//  ReviewInteractor.swift
//  Movie
//
//  Created by Michael Agustian on 15/04/21.
//

import Foundation

protocol ReviewUseCase: AnyObject {
    func getReviews(withMovieId movieId: Int, page: Int, completion: @escaping (Result<[ReviewModel], Error>) -> Void)
}

final class ReviewInteractor {

    // MARK: - Properties

    private let repository: ReviewRepositoryProtocol

    // MARK: - Initialisation

    init(repository: ReviewRepositoryProtocol) {
        self.repository = repository
    }

}

// MARK: - MovieUseCase

extension ReviewInteractor: ReviewUseCase {

    func getReviews(withMovieId movieId: Int, page: Int, completion: @escaping (Result<[ReviewModel], Error>) -> Void) {
        repository.getReviews(withMovieId: movieId, page: page) { repositoryResult in
            completion(repositoryResult)
        }
    }

}
