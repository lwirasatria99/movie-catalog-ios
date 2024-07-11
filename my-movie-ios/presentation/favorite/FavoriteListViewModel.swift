//
//  FavoriteListViewModel.swift
//  my-movie-ios
//
//  Created by wira-klikdokter on 11/07/24.
//

import Foundation
import CoreData

class FavoriteListViewModel: ObservableObject {
    
    @Published var favoriteMovies: [Movie] = []
    private let fetchFavoriteMoviesUseCase: FetchFavoritesUseCase
    
    init(fetchFavoriteMoviesUseCase: FetchFavoritesUseCase) {
            self.fetchFavoriteMoviesUseCase = fetchFavoriteMoviesUseCase
            fetchFavorites()
        }
    
    func fetchFavorites() {
        favoriteMovies = fetchFavoriteMoviesUseCase.execute()
    }
}
