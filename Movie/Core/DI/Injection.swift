//
//  Injection.swift
//  Movie
//
//  Created by Michael Agustian on 14/04/21.
//

import Foundation

final class Injection {

    // MARK: - Genre

    private func provideGenreRepository() -> GenreRepositoryProtocol {
        let remote: RemoteDataSource = RemoteDataSource()
        return GenreRepository(remoteDataSource: remote)
    }

    func provideGenre() -> GenreUseCase {
        let repository = provideGenreRepository()
        return GenreInteractor(repository: repository)
    }

}
