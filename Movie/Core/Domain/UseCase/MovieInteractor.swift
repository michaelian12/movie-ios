//
//  MovieInteractor.swift
//  Movie
//
//  Created by Michael Agustian on 15/04/21.
//

import Foundation

protocol MovieUseCase: AnyObject {
    func getMovies(withGenreId genreId: Int, completion: @escaping (Result<[MovieModel], Error>) -> Void)
}

final class MovieInteractor {

    // MARK: - Properties

    private let repository: MovieRepositoryProtocol

    // MARK: - Initialisation

    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
}

// MARK: - MovieUseCase

extension MovieInteractor: MovieUseCase {

    func getMovies(withGenreId genreId: Int, completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        repository.getMovies(withGenreId: genreId) { repositoryResult in
            completion(repositoryResult)
        }
    }

}
