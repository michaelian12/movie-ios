//
//  MovieDetailRemoteDataSource.swift
//  Movie
//
//  Created by Michael Agustian on 16/04/21.
//

import Foundation
import Alamofire

protocol MovieDetailRemoteDataSourceProtocol: AnyObject {
    func getVideos(withMovieId movieId: Int, result: @escaping (Result<[VideoResponse], URLError>) -> Void)
}

final class MovieDetailRemoteDataSource: RemoteDataSource, MovieDetailRemoteDataSourceProtocol {

    func getVideos(withMovieId movieId: Int, result: @escaping (Result<[VideoResponse], URLError>) -> Void) {
        guard let _url = URL(string: Endpoints.Gets.videos(movieId: movieId).url) else { return }

        AF.request(_url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil)
            .validate()
            .responseDecodable(of: ListResponse<VideoResponse>.self) { dataResponse in
                switch dataResponse.result {
                case .success(let videoListResponse):
                    if let _videos = videoListResponse.results {
                        result(.success(_videos))
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
