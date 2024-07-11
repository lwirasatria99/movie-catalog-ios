//
//  GetMoviesUseCase.swift
//  my-movie-ios
//
//  Created by wira-klikdokter on 11/07/24.
//

import Foundation

class GetMoviesUseCase {
    private let movieRepository: MovieRepository

    init(movieRepository: MovieRepository) {
       self.movieRepository = movieRepository
    }
    
    func execute(query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        movieRepository.getMovies(query: query, completion: completion)
    }
}
