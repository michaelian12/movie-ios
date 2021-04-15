//
//  APICall.swift
//  Movie
//
//  Created by Michael Agustian on 14/04/21.
//

import Foundation

struct API {
    static let baseUrl = "https://api.themoviedb.org/3/"
    static let key = "b1bd0b60042274302e67670f173ef398"
}

protocol Endpoint {
    var url: String { get }
}

enum Endpoints {

    enum Gets: Endpoint {
        case genres

        var url: String {
            switch self {
//            case .genres: return "\(API.baseUrl)genre/movie/list?api_key=\(API.key)"
            case .genres: return "\(API.baseUrl)genre/movie/list"
            }
        }
    }

}
