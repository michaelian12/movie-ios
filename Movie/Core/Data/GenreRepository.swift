//
//  GenreRepository.swift
//  Movie
//
//  Created by Michael Agustian on 14/04/21.
//

import Foundation

protocol GenreRepositoryProtocol: AnyObject {
    func getGenres(result: @escaping (Result<[GenreModel], Error>) -> Void)
}

final class GenreRepository {

    // MARK: - Properties

    private let remote: GenreRemoteDataSourceProtocol

    // MARK: - Initialisation

    init(remoteDataSource: GenreRemoteDataSourceProtocol) {
        self.remote = remoteDataSource
    }

}

// MARK: - GenreRepositoryProtocol

extension GenreRepository: GenreRepositoryProtocol {

    func getGenres(result: @escaping (Result<[GenreModel], Error>) -> Void) {
        remote.getGenres { remoteResult in
            switch remoteResult {
            case .success(let genreResponses):
                let _genres = GenreMapper.mapGenreResponsesToDomains(input: genreResponses)
                result(.success(_genres))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }

}
