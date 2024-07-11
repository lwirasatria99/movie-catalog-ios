//
//  MovieRepositoryImpl.swift
//  my-movie-ios
//
//  Created by wira-klikdokter on 11/07/24.
//

import Foundation
import CoreData

class MovieRepositoryImpl: MovieRepository {
    
    private let apiService: ApiService
    private let persistentContainer: NSPersistentContainer
    
    init(apiService: ApiService, persistentContainer: NSPersistentContainer) {
        self.apiService = apiService
        self.persistentContainer = persistentContainer
    }
    
    func getMovies(query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        apiService.fetchMovies(query: query) { result in
            switch result {
            case .success(let movieResponse):
                let movies = movieResponse.map { response in
                    Movie(
                        title: response.title,
                        imagePath: response.imagePath,
                        rating: response.rating
                    )
                }
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchFavoriteMovies() -> [Movie] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<FavoriteMovieEntity> = FavoriteMovieEntity.fetchRequest()
        
        do {
            let favoriteMovies = try context.fetch(fetchRequest)
            return favoriteMovies.map { movie in
                Movie(title: movie.title ?? "",
                      imagePath: movie.imagePath ?? "",
                      rating: movie.rating
                )
            }
        } catch {
            print("Failed to fetch favorite movies: \(error)")
            return []
        }
    }
    
    func saveFavoriteMovie(movie: Movie) {
        let context = persistentContainer.viewContext
        let favoriteMovie = FavoriteMovieEntity(context: context)
        favoriteMovie.title = movie.title
        favoriteMovie.rating = movie.rating
        favoriteMovie.imagePath = movie.imagePath
        
        do {
            try context.save()
        } catch {
            print("Failed to save favorite movie: \(error)")
        }
    }
}
