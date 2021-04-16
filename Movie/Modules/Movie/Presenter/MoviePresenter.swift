//
//  MoviePresenter.swift
//  Movie
//
//  Created by Michael Agustian on 15/04/21.
//

import Foundation

protocol MoviePresenterProtocol: AnyObject {
    var genre: GenreModel { get }
    var movies: [MovieModel] { get }
    var page: Int { get set }
    func getMovies(withGenreId genreId: Int)
}

final class MoviePresenter {

    // MARK: - Properties

    private let movieUseCase: MovieUseCase
    private weak var view: MovieTableViewController?
    let genre: GenreModel
    var movies: [MovieModel] = []
    var page: Int = 1

    // MARK: - Initialisation

    init(genre: GenreModel, useCase: MovieUseCase) {
        self.genre = genre
        self.movieUseCase = useCase
    }

    // MARK: - Methods

    func setView(_ view: MovieTableViewController) {
        self.view = view
    }

}

// MARK: - MoviePresenterProtocol

extension MoviePresenter: MoviePresenterProtocol {

    func getMovies(withGenreId genreId: Int) {
        movieUseCase.getMovies(withGenreId: genreId, page: page) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let movies):
                if movies.isEmpty {
                    if self.page > 1 { self.page -= 1 }
                } else {
                    if self.page == 1 {
                        self.movies = movies
                    } else {
                        self.movies.append(contentsOf: movies)
                    }
                }

                self.view?.endRefreshing()
            case .failure(let error):
                self.view?.endRefreshing()
                let _errorMessage = error.localizedDescription
                self.view?.showToast(message: _errorMessage)
            }
        }
    }

}
