//
//  MovieRepository.swift
//  Movie
//
//  Created by Michael Agustian on 15/04/21.
//

import Foundation

protocol MovieRepositoryProtocol: AnyObject {
    func getMovies(withGenreId genreId: Int, page: Int, result: @escaping (Result<[MovieModel], Error>) -> Void)
}

final class MovieRepository {

    // MARK: - Properties

    private let remote: MovieRemoteDataSourceProtocol

    // MARK: - Initialisation

    init(remoteDataSource: MovieRemoteDataSourceProtocol) {
        self.remote = remoteDataSource
    }
    
}

// MARK: - MovieRepositoryProtocol

extension MovieRepository: MovieRepositoryProtocol {

    func getMovies(withGenreId genreId: Int, page: Int, result: @escaping (Result<[MovieModel], Error>) -> Void) {
        remote.getMovies(withGenreId: genreId, page: page) { remoteResult in
            switch remoteResult {
            case .success(let movieResponses):
                let _movies = MovieMapper.mapMovieResponsesToDomains(input: movieResponses)
                result(.success(_movies))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }

}
