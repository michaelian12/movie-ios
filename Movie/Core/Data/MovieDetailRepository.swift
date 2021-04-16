//
//  MovieDetailRepository.swift
//  Movie
//
//  Created by Michael Agustian on 16/04/21.
//

import Foundation

protocol MovieDetailRepositoryProtocol: AnyObject {
    func getVideos(withMovieId movieId: Int, result: @escaping (Result<[VideoModel], Error>) -> Void)
}

final class MovieDetailRepository {

    // MARK: - Properties

    private let remote: MovieDetailRemoteDataSourceProtocol

    // MARK: - Initialisation

    init(remoteDataSource: MovieDetailRemoteDataSourceProtocol) {
        self.remote = remoteDataSource
    }

}

// MARK: - MovieDetailRepositoryProtocol

extension MovieDetailRepository: MovieDetailRepositoryProtocol {

    func getVideos(withMovieId movieId: Int, result: @escaping (Result<[VideoModel], Error>) -> Void) {
        remote.getVideos(withMovieId: movieId) { remoteResult in
            switch remoteResult {
            case .success(let videoResponses):
                let _videos = VideoMapper.mapVideoResponsesToDomains(input: videoResponses)
                result(.success(_videos))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }

}
