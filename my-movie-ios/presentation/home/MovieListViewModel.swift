//
//  MovieListViewModel.swift
//  my-movie-ios
//
//  Created by wira on 11/07/24.
//

import Foundation
import Combine
import CoreData

class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var searchQuery: String = ""
    @Published var errorMessage: ErrorMessage?
    @Published var isLoading: Bool = false
    @Published var successMessage: String = ""
    
    private var cancellables: Set<AnyCancellable> = []
    private let getMoviesUseCase: GetMoviesUseCase
    private let persistanceController: PersistenceController
    
    init(getMoviesUseCase: GetMoviesUseCase, persistanceController: PersistenceController) {
        self.getMoviesUseCase = getMoviesUseCase
        self.persistanceController = persistanceController
        
        fetchMovies(query: "A") // Fetch initial movies
        
        $searchQuery
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink { [weak self] query in
                self?.fetchMovies(query: query)
            }
            .store(in: &cancellables)
    }
    
    func fetchMovies(query: String) {
        isLoading = true
        
        getMoviesUseCase.execute(query: query) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let movies):
                    self?.movies = movies
                case .failure(let error):
                    self?.errorMessage = ErrorMessage(message: error.localizedDescription)
                }
            }
        }
    }
    
    // TODO need to refactor to usecase later
    func saveFavorite(movie: Movie) {
        let context = persistanceController.container.viewContext
        
        context.perform {
            let favoriteMovie = FavoriteMovieEntity(context: context)
            favoriteMovie.title = movie.title
            favoriteMovie.imagePath = movie.imagePath
            favoriteMovie.rating = movie.rating
            
            do {
                try context.save()
                self.successMessage = "Added \(movie.title) to favorites!"
            } catch {
                print("Failed to save favorite movie: \(error.localizedDescription)")
            }
        }
    }
}
