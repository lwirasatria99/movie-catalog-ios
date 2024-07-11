//
//  FetchFavoriteMoviesUseCaseTests.swift
//  my-movie-iosTests
//
//  Created by wira-klikdokter on 11/07/24.
//

import Foundation
import XCTest
@testable import my_movie_ios

class MockMovieRepository: MovieRepository {
    func getMovies(query: String, completion: @escaping (Result<[my_movie_ios.Movie], any Error>) -> Void) {
        
    }
    
    var mockMovies: [Movie] = []
    
    func saveFavoriteMovie(movie: Movie) {
        mockMovies.append(movie)
    }
    
    func fetchFavoriteMovies() -> [Movie] {
        return mockMovies
    }
}

class FetchFavoriteMoviesUseCaseTests: XCTestCase {
    
    var mockRepository: MockMovieRepository!
    var fetchFavoritesUseCase: FetchFavoritesUseCase!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockMovieRepository()
        fetchFavoritesUseCase = FetchFavoritesUseCase(movieRepository: mockRepository)
    }
    
    override func tearDown() {
        mockRepository = nil
        fetchFavoritesUseCase = nil
        super.tearDown()
    }
    
    func testFetchFavorites() {
        // Given
        let movie1 = Movie(title: "Test Movie 1", imagePath: "test_image_path_1", rating: 4.5)
        let movie2 = Movie(title: "Test Movie 2", imagePath: "test_image_path_2", rating: 3.8)
        
        mockRepository.saveFavoriteMovie(movie: movie1)
        mockRepository.saveFavoriteMovie(movie: movie2)
        
        // When
        let fetchedMovies = fetchFavoritesUseCase.execute()
        
        // Then
        XCTAssertEqual(fetchedMovies.count, 2, "Expected two favorite movies to be fetched")
        XCTAssertEqual(fetchedMovies[0].title, "Test Movie 1", "Expected fetched movie title to match")
        XCTAssertEqual(fetchedMovies[0].rating, 4.5, "Expected fetched movie rating to match")
        XCTAssertEqual(fetchedMovies[0].imagePath, "test_image_path_1", "Expected fetched movie imagePath to match")
        XCTAssertEqual(fetchedMovies[1].title, "Test Movie 2", "Expected fetched movie title to match")
        XCTAssertEqual(fetchedMovies[1].rating, 3.8, "Expected fetched movie rating to match")
        XCTAssertEqual(fetchedMovies[1].imagePath, "test_image_path_2", "Expected fetched movie imagePath to match")
    }
    
    func testFetchFavoritesEmpty() {
        // When
        let fetchedMovies = fetchFavoritesUseCase.execute()
        
        // Then
        XCTAssertEqual(fetchedMovies.count, 0, "Expected no favorite movies initially")
    }
}

