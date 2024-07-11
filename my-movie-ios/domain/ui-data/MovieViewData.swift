//
//  MovieViewData.swift
//  my-movie-ios
//
//  Created by wira-klikdokter on 11/07/24.
//

import Foundation

class Movie: Identifiable {
    let title: String
    let imagePath: String
    let rating: Double

    init(title: String, imagePath: String, rating: Double) {
        self.title = title
        self.imagePath = imagePath
        self.rating = rating
    }
}
