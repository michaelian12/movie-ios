//
//  GenresResponse.swift
//  Movie
//
//  Created by Michael Agustian on 14/04/21.
//

import Foundation

struct GenresResponse: Decodable {
    let genres: [GenreResponse]
}

struct GenreResponse: Decodable {
    let id: Int?
    let name: String?
}
