//
//  FetchCountriesUseCase.swift
//  my-movie-ios
//
//  Created by wira-klikdokter on 10/07/24.
//

import Foundation

class FetchCountriesUseCase {
    private let repository: CountryRepository
    
    init(repository: CountryRepository) {
        self.repository = repository
    }
    
    func execute(completion: @escaping (Result<[Country], Error>) -> Void) {
        repository.fetchApiCountries(completion: completion)
    }
}
