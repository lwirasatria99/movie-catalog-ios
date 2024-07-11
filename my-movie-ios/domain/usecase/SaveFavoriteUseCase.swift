//
//  SaveFavoriteUseCase.swift
//  my-movie-ios
//
//  Created by wira-klikdokter on 11/07/24.
//

import Foundation

protocol SaveMovieUseCase {
    func execute(movie: Movie)
}

class SaveFavoriteUseCase: SaveMovieUseCase {
    
    private let movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func execute(movie: Movie) {
        movieRepository.saveFavoriteMovie(movie: movie)
    }
}
