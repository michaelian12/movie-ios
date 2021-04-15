//
//  GenrePresenter.swift
//  Movie
//
//  Created by Michael Agustian on 13/04/21.
//

import Foundation

protocol GenrePresenterProtocol: AnyObject {
    var genres: [GenreModel] { get }
    func getGenres()
}

final class GenrePresenter {

    // MARK: - Properties

    private let genreUseCase: GenreUseCase
    private weak var view: GenreTableViewController?
    var genres: [GenreModel] = []
    var errorMessage: String = ""

    // MARK: - Initialisation

    init(useCase: GenreUseCase) {
        self.genreUseCase = useCase
    }

    // MARK: - Methods

    func setView(_ view: GenreTableViewController) {
        self.view = view
    }
    
}

// MARK: - GenrePresenterProtocol

extension GenrePresenter: GenrePresenterProtocol {

    func getGenres() {
        genreUseCase.getGenres { [weak self] result in
            switch result {
            case .success(let genres):
                self?.genres = genres
                self?.view?.tableView.reloadData()
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
        }
    }
    
}
