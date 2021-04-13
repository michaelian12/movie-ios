//
//  GenrePresenter.swift
//  Movie
//
//  Created by Michael Agustian on 13/04/21.
//

import Foundation

final class GenrePresenter {

    // MARK: - Properties

    var genres: [GenreModel] = []

    // MARK: Methods

    func getGenres() {
        let genre = GenreModel(id: 1, name: "Action")
        genres.append(genre)
    }

}
