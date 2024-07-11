//
//  CountryRepository.swift
//  my-movie-ios
//
//  Created by wira-klikdokter on 10/07/24.
//

protocol CountryRepository {
    
    func fetchCountries() -> [Country]
    
    func fetchApiCountries(completion: @escaping (Result<[Country], Error>) -> Void)
    
    func fetchApiCountries2() async throws -> [Country]
}
