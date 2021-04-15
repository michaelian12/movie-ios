//
//  CustomError.swift
//  Movie
//
//  Created by Michael Agustian on 14/04/21.
//

import Foundation

enum URLError: LocalizedError {

    case generalError(errorMessage: String)
    case invalidResponse
    case addressUnreachable(URL)

    var errorDescription: String? {
        switch self {
        case .generalError(let errorMessage): return errorMessage
        case .invalidResponse: return "The server responded with garbage."
        case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
        }
    }

}
