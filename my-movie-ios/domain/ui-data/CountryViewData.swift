//
//  CountryViewData.swift
//  my-movie-ios
//
//  Created by wira on 10/07/24.
//

import Foundation

struct CountryViewData: Identifiable {
    let id = UUID()
    let name: String
    let population: String
    let imageName: String
    
    init(country: Country) {
        self.name = country.name
        self.population = "Population: \(country.population)"
        self.imageName = country.imageName
    }
}
