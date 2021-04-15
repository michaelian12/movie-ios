//
//  MoviePresenter.swift
//  Movie
//
//  Created by Michael Agustian on 15/04/21.
//

import Foundation

protocol MoviePresenterProtocol: AnyObject {
    var movies: [MovieModel] { get }
    func getMovie(withGenreId: Int)
}

final class MoviePresenter {

    // MARK: - Properties

    var movies: [MovieModel] = []
    var errorMessage: String = ""

}

// MARK: - MoviePresenterProtocol

extension MoviePresenter: MoviePresenterProtocol {

    func getMovie(withGenreId: Int) {
        let movie = MovieModel(id: 1, title: "Godzilla vs. Kong", overview: "In a time when monsters walk the Earth, humanity’s fight for its future sets Godzilla and Kong on a collision course that will see the two most powerful forces of nature on the planet collide in a spectacular battle for the ages.")
        movies.append(movie)
    }

}
