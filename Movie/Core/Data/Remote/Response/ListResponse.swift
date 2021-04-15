//
//  ListResponse.swift
//  Movie
//
//  Created by Michael Agustian on 15/04/21.
//

import Foundation

struct ListResponse<T: Decodable>: Decodable {

    private enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

    let page: Int?
    let results: [T]?
    let totalPages: Int?
    let totalResults: Int?

}
