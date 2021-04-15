//
//  MovieResponse.swift
//  Movie
//
//  Created by Michael Agustian on 15/04/21.
//

import Foundation

struct MovieResponse: Decodable {

    private enum CodingKeys: String, CodingKey {
        case id, title, overview
        case backdropPath = "backdrop_path"
    }

    let id: Int?
    let title: String?
    let overview: String?
    let backdropPath: String?

}
