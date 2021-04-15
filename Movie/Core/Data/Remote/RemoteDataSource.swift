//
//  RemoteDataSource.swift
//  Movie
//
//  Created by Michael Agustian on 14/04/21.
//

import Foundation
import Alamofire

protocol RemoteDataSourceProtocol: AnyObject {
    func getGenres(result: @escaping (Result<[GenreResponse], URLError>) -> Void)
}

final class RemoteDataSource: RemoteDataSourceProtocol {

    private let parameters: Parameters = ["api_key": API.key]

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
                    result(.failure(.generalError(errorMessage: _errorResponse.message ?? "Unknown error")))
                }
            }
    }
    
}

