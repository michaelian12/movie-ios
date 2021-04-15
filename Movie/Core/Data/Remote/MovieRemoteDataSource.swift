//
//  MovieRemoteDataSource.swift
//  Movie
//
//  Created by Michael Agustian on 15/04/21.
//

import Foundation
import Alamofire

protocol MovieRemoteDataSourceProtocol: AnyObject {
    func getMovies(withGenreId genreId: Int, page: Int, result: @escaping (Result<[MovieResponse], URLError>) -> Void)
}

final class MovieRemoteDataSource: RemoteDataSource, MovieRemoteDataSourceProtocol {

    func getMovies(withGenreId genreId: Int, page: Int, result: @escaping (Result<[MovieResponse], URLError>) -> Void) {
        guard let _url = URL(string: Endpoints.Gets.moviesWithGenreId.url) else { return }

        parameters["with_genres"] = genreId
        parameters["page"] = page

        AF.request(_url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil)
            .validate()
            .responseDecodable(of: EnumResponse.self) { dataResponse in
                switch dataResponse.result {
                case .success(let enumResponse):
                    switch enumResponse {
                    case .movieListResponse:
                        guard let _movies = (enumResponse.get() as? [MovieResponse]) else { return }
                        result(.success(_movies))
                    default:
                        result(.failure(.invalidResponse))
                    }
                case .failure:
                    guard let _data = dataResponse.data,
                          let _errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: _data)
                    else { return }
                    let _errorMessage = _errorResponse.message ?? "Unknown error"
                    result(.failure(.generalError(errorMessage: _errorMessage)))
                }
            }
    }
    
}
