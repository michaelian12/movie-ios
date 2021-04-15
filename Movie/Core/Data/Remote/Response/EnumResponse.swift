//
//  EnumResponse.swift
//  Movie
//
//  Created by Michael Agustian on 15/04/21.
//

import Foundation

enum EnumResponse: Decodable {

    case genresResponse(GenresResponse)
    case errorResponse(ErrorResponse)
    case unknown

    // MARK: - Initialisation

    init(from decoder: Decoder) throws {
        let _container = try decoder.singleValueContainer()

        if let _genresResponseValue = try? _container.decode(GenresResponse.self) {
            self = .genresResponse(_genresResponseValue)
            return
        }

        if let _errorResponseValue = try? _container.decode(ErrorResponse.self) {
            self = .errorResponse(_errorResponseValue)
            return
        }

        self = .unknown
    }

    func get() -> Any {
        switch self {
        case .genresResponse(let genresResponse):
            return genresResponse
        case .errorResponse(let errorResponse):
            return errorResponse
        case .unknown:
            return "Unknown response"
        }
    }

}
