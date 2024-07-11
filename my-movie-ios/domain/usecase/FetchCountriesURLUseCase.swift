//
//  FetchCountriesURLUseCase.swift
//  my-movie-ios
//
//  Created by wira-klikdokter on 10/07/24.
//

import Foundation

class FetchCountriesURLUseCase {
    private let repository: CountryRepository
    
    init(repository: CountryRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> [Country] {
        return try await repository.fetchApiCountries2()
    }
}
