//
//  ReviewRepository.swift
//  Movie
//
//  Created by Michael Agustian on 15/04/21.
//

import Foundation

protocol ReviewRepositoryProtocol: AnyObject {
    func getReviews(withMovieId movieId: Int, result: @escaping (Result<[ReviewModel], Error>) -> Void)
}

final class ReviewRepository {

    // MARK: - Properties

    private let remote: ReviewRemoteDataSourceProtocol

    // MARK: - Initialisation

    init(remoteDataSource: ReviewRemoteDataSourceProtocol) {
        self.remote = remoteDataSource
    }

}

// MARK: - ReviewRepositoryProtocol

extension ReviewRepository: ReviewRepositoryProtocol {

    func getReviews(withMovieId movieId: Int, result: @escaping (Result<[ReviewModel], Error>) -> Void) {
        remote.getReviews(withMovieId: movieId) { remoteResult in
            switch remoteResult {
            case .success(let reviewResponses):
                let _reviews = ReviewMapper.mapReviewResponsesToDomains(input: reviewResponses)
                result(.success(_reviews))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }

}
