//
//  MovieRepository.swift
//  my-movie-ios
//
//  Created by wira-klikdokter on 11/07/24.
//

import Foundation

protocol MovieRepository {
    
    func getMovies(query: String, completion: @escaping (Result<[Movie], Error>) -> Void)
    
    func fetchFavoriteMovies() -> [Movie]
    
    func saveFavoriteMovie(movie: Movie)
}
