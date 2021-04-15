//
//  MovieDetailPresenter.swift
//  Movie
//
//  Created by Michael Agustian on 15/04/21.
//

import Foundation

protocol MovieDetailPresenterProtocol {
    var movie: MovieModel { get }
}

final class MovieDetailPresenter: MovieDetailPresenterProtocol {

    // MARK: - Properties

    let movie: MovieModel

    // MARK: - Initialisation

    init(movie: MovieModel) {
        self.movie = movie
    }

}
