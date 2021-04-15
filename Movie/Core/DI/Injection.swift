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
        let remote = GenreRemoteDataSource()
        return GenreRepository(remoteDataSource: remote)
    }

    func provideGenre() -> GenreUseCase {
        let repository = provideGenreRepository()
        return GenreInteractor(repository: repository)
    }

    // MARK: - Movie

    private func provideMovieRepository() -> MovieRepositoryProtocol {
        let remote = MovieRemoteDataSource()
        return MovieRepository(remoteDataSource: remote)
    }

    func provideMovie() -> MovieUseCase {
        let repository = provideMovieRepository()
        return MovieInteractor(repository: repository)
    }

}
