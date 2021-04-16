//
//  ReviewRemoteDataSource.swift
//  Movie
//
//  Created by Michael Agustian on 15/04/21.
//

import Foundation
import Alamofire

protocol ReviewRemoteDataSourceProtocol: AnyObject {
    func getReviews(withMovieId movieId: Int, page: Int, result: @escaping (Result<[ReviewResponse], URLError>) -> Void)
}

final class ReviewRemoteDataSource: RemoteDataSource, ReviewRemoteDataSourceProtocol {

    func getReviews(withMovieId movieId: Int, page: Int, result: @escaping (Result<[ReviewResponse], URLError>) -> Void) {
        guard let _url = URL(string: Endpoints.Gets.review(movieId: movieId).url) else { return }

        parameters["page"] = page

        AF.request(_url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil)
            .validate()
            .responseDecodable(of: ListResponse<ReviewResponse>.self) { dataResponse in
                switch dataResponse.result {
                case .success(let reviewListResponse):
                    if let _reviews = reviewListResponse.results {
                        result(.success(_reviews))
                    } else {
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
