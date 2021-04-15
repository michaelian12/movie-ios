//
//  ErrorResponse.swift
//  Movie
//
//  Created by Michael Agustian on 15/04/21.
//

import Foundation

struct ErrorResponse: Decodable {

    private enum CodingKeys: String, CodingKey {
        case code = "status_code"
        case message = "status_message"
    }

    let code: Int?
    let message: String?

}
