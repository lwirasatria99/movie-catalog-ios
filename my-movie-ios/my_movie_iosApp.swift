//
//  my_movie_iosApp.swift
//  my-movie-ios
//
//  Created by wira on 10/07/24.
//

import SwiftUI

@main
struct my_movie_iosApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            let apiService = ApiService()
            let movieRepository = MovieRepositoryImpl(apiService: apiService, persistentContainer: persistenceController.container)
            
            let getMoviesUseCase = GetMoviesUseCase(movieRepository: movieRepository)
            let fetchFavoriteUseCase = FetchFavoritesUseCase(movieRepository: movieRepository)
            
            let movieListViewModel = MovieListViewModel(getMoviesUseCase: getMoviesUseCase, persistanceController: persistenceController)
            let favoriteListViewModel = FavoriteListViewModel(fetchFavoriteMoviesUseCase: fetchFavoriteUseCase)
            
            MovieListView(viewModel: movieListViewModel, viewModelFavorite: favoriteListViewModel)
                .environment(
                    \.managedObjectContext, persistenceController.container.viewContext
                )
        }
    }
}
