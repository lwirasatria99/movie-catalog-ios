//
//  CountryListViewModel.swift
//  my-movie-ios
//
//  Created by wira-klikdokter on 10/07/24.
//

import Foundation

class CountryListViewModel: ObservableObject {
    
    @Published var countries: [CountryViewData] = []
    @Published var errorMessage: ErrorMessage? = nil
    
    private let fetchCountriesUseCase: FetchCountriesUseCase
    private let fetchUseCase: FetchCountriesURLUseCase
    
    init(fetchCountriesUseCase: FetchCountriesUseCase,
         fetchUseCase: FetchCountriesURLUseCase) {
        self.fetchCountriesUseCase = fetchCountriesUseCase
        self.fetchUseCase = fetchUseCase
        
        //Sample Alamofire
        //loadCountries()
        
        //Sample async
        Task {
            await loadCountries2()
        }
    }
    
    func loadCountries() {
        
        fetchCountriesUseCase.execute { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let countries):
                    self.countries = countries.map {CountryViewData(country: $0)}
                case .failure(let error):
                    self.errorMessage = ErrorMessage(message: error.localizedDescription)
                }
            }
        }
    }
    
    func loadCountries2() async {
        do {
            let countries = try await fetchUseCase.execute()
            DispatchQueue.main.async {
                self.countries = countries.map { CountryViewData(country: $0) }
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = ErrorMessage(message: error.localizedDescription)
            }
        }
    }
}
