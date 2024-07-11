//
//  FetchFavoritesUseCase.swift
//  my-movie-ios
//
//  Created by wira-klikdokter on 11/07/24.
//

import Foundation

protocol FetchMoviesUseCase {
    func execute() -> [Movie]
}

class FetchFavoritesUseCase: FetchMoviesUseCase {
    
    private let movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func execute() -> [Movie] {
        return movieRepository.fetchFavoriteMovies()
    }
}
