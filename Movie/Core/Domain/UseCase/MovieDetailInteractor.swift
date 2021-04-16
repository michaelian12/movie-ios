//
//  MovieDetailInteractor.swift
//  Movie
//
//  Created by Michael Agustian on 16/04/21.
//

import Foundation

protocol MovieDetailUseCase: AnyObject {
    func getVideos(withMovieId movieId: Int, completion: @escaping (Result<[VideoModel], Error>) -> Void)
}

final class MovieDetailInteractor {

    // MARK: - Properties

    private let repository: MovieDetailRepositoryProtocol

    // MARK: - Initialisation

    init(repository: MovieDetailRepositoryProtocol) {
        self.repository = repository
    }

}

// MARK: - MovieUseCase

extension MovieDetailInteractor: MovieDetailUseCase {

    func getVideos(withMovieId movieId: Int, completion: @escaping (Result<[VideoModel], Error>) -> Void) {
        repository.getVideos(withMovieId: movieId) { repositoryResult in
            completion(repositoryResult)
        }
    }

}
