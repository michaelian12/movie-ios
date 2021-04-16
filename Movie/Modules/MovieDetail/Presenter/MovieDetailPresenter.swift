//
//  MovieDetailPresenter.swift
//  Movie
//
//  Created by Michael Agustian on 15/04/21.
//

import Foundation

protocol MovieDetailPresenterProtocol {
    var movie: MovieModel { get }
    var youTubeId: String { get }
    func getTrailerVideo(withMovieId movieId: Int)
}

final class MovieDetailPresenter {

    // MARK: - Properties

    private let movieDetailUseCase: MovieDetailUseCase
    private weak var view: MovieDetailViewController?
    let movie: MovieModel
    var youTubeId: String = ""

    // MARK: - Initialisation

    init(movie: MovieModel, useCase: MovieDetailUseCase) {
        self.movie = movie
        self.movieDetailUseCase = useCase
    }

    // MARK: - Methods

    func setView(_ view: MovieDetailViewController) {
        self.view = view
    }

}

// MARK: - MovieDetailPresenterProtocol

extension MovieDetailPresenter: MovieDetailPresenterProtocol {

    func getTrailerVideo(withMovieId movieId: Int) {
        movieDetailUseCase.getVideos(withMovieId: movieId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let videos):
                self.youTubeId = videos[0].youTubeId
                self.view?.setMovieDetail()
            case .failure(let error):
                let _errorMessage = error.localizedDescription
                self.view?.showToast(message: _errorMessage)
            }
        }
    }


}
