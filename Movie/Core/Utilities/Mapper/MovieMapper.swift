//
//  MovieMapper.swift
//  Movie
//
//  Created by Michael Agustian on 15/04/21.
//

import Foundation

final class MovieMapper {

    static func mapMovieResponsesToDomains(input movieResponse: [MovieResponse]) -> [MovieModel] {
        return movieResponse.map { result in
            return MovieModel(id: result.id ?? 0,
                              title: result.title ?? "Unknown title",
                              overview: result.overview ?? "Unknown overview",
                              backdropPath: result.backdropPath ?? "")
        }
    }

}
