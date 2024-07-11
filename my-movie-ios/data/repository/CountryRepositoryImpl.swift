//
//  CountryRepositoryImpl.swift
//  my-movie-ios
//
//  Created by wira-klikdokter on 10/07/24.
//

import Foundation
import Alamofire

class CountryRepositoryImpl: CountryRepository {
    
    private let baseUrl = "https://streaming-availability.p.rapidapi.com/shows/search/title"
    private let apiKey = "d4a30a47dcmsh619410b357ba35bp19b41ejsn02359b5166d6"
    
    fileprivate func fetchLocalCountries() -> [Country] {
        return [
            Country(name: "USA", population: 331449281, imageName: "usa"),
            Country(name: "China", population: 1444216107, imageName: "china"),
            Country(name: "India", population: 1393409038, imageName: "india"),
            Country(name: "Brazil", population: 213993437, imageName: "brazil")
        ]
    }
    
    // Local example
    func fetchCountries() -> [Country] {
        return fetchLocalCountries()
    }
    
    // Alamofire example
    func fetchApiCountries(completion: @escaping (Result<[Country], any Error>) -> Void) {
        let url = "https://api.wira.dev/countries"
        
        AF.request(url).responseDecodable(of: [Country].self) { response in
            switch response.result {
            case .success(let countries):
                completion(.success(countries))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // URLSession example
    func fetchApiCountries2() async throws -> [Country] {
        let url = URL(string: "https://api.wira.dev/countries")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Country].self, from: data)
    }
    
    
}
