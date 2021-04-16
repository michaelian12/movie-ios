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
        let _remote = GenreRemoteDataSource()
        return GenreRepository(remoteDataSource: _remote)
    }

    func provideGenre() -> GenreUseCase {
        let _repository = provideGenreRepository()
        return GenreInteractor(repository: _repository)
    }

    // MARK: - Movie

    private func provideMovieRepository() -> MovieRepositoryProtocol {
        let _remote = MovieRemoteDataSource()
        return MovieRepository(remoteDataSource: _remote)
    }

    func provideMovie() -> MovieUseCase {
        let _repository = provideMovieRepository()
        return MovieInteractor(repository: _repository)
    }

    // MARK: - MovieDetail

    private func provideMovieDetailRepository() -> MovieDetailRepositoryProtocol {
        let _remote = MovieDetailRemoteDataSource()
        return MovieDetailRepository(remoteDataSource: _remote)
    }

    func provideMovieDetail() -> MovieDetailUseCase {
        let _repository = provideMovieDetailRepository()
        return MovieDetailInteractor(repository: _repository)
    }

    // MARK: - Review

    private func provideReviewRepository() -> ReviewRepositoryProtocol {
        let _remote = ReviewRemoteDataSource()
        return ReviewRepository(remoteDataSource: _remote)
    }

    func provideReview() -> ReviewUseCase {
        let _repository = provideReviewRepository()
        return ReviewInteractor(repository: _repository)
    }

}
