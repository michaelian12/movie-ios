//
//  GenreInteractor.swift
//  Movie
//
//  Created by Michael Agustian on 14/04/21.
//

import Foundation

protocol GenreUseCase: AnyObject {
    func getGenres(completion: @escaping (Result<[GenreModel], Error>) -> Void)
}

final class GenreInteractor {

    // MARK: - Properties

    private let repository: GenreRepositoryProtocol

    // MARK: - Initialisation

    init(repository: GenreRepositoryProtocol) {
        self.repository = repository
    }

}

// MARK: - GenreUseCase

extension GenreInteractor: GenreUseCase {
    
    func getGenres(completion: @escaping (Result<[GenreModel], Error>) -> Void) {
        return repository.getGenres { repositoryResult in
            completion(repositoryResult)
        }
    }

}
