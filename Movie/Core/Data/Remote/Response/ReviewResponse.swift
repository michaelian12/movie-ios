//
//  ReviewResponse.swift
//  Movie
//
//  Created by Michael Agustian on 15/04/21.
//

import Foundation

struct ReviewResponse: Decodable {
    let id: String?
    let author: String?
    let content: String?
}
