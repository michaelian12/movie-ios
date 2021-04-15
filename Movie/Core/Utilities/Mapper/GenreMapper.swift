//
//  GenreMapper.swift
//  Movie
//
//  Created by Michael Agustian on 14/04/21.
//

import Foundation

final class GenreMapper {

    static func mapGenreResponsesToDomains(input genreResponse: [GenreResponse]) -> [GenreModel] {
        return genreResponse.map { result in
            return GenreModel(id: result.id ?? 0,
                              name: result.name ?? "Unknown title")
        }
    }

}
