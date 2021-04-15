//
//  GenreRemoteDataSource.swift
//  Movie
//
//  Created by Michael Agustian on 15/04/21.
//

import Foundation
import Alamofire

protocol GenreRemoteDataSourceProtocol: AnyObject {
    func getGenres(result: @escaping (Result<[GenreResponse], URLError>) -> Void)
}

final class GenreRemoteDataSource: RemoteDataSource, GenreRemoteDataSourceProtocol {

    func getGenres(result: @escaping (Result<[GenreResponse], URLError>) -> Void) {
        guard let _url = URL(string: Endpoints.Gets.genres.url) else { return }

        AF.request(_url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil)
            .validate()
            .responseDecodable(of: EnumResponse.self) { dataResponse in
                switch dataResponse.result {
                case .success(let enumResponse):
                    switch enumResponse {
                    case .genresResponse:
                        guard let _genres = (enumResponse.get() as? GenresResponse)?.genres else { return }
                        result(.success(_genres))
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
