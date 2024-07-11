//
//  MovieResponse.swift
//  my-movie-ios
//
//  Created by wira on 11/07/24.
//

import Foundation

class MovieResponse: Movie, Codable {
    
    enum CodingKeys: String, CodingKey {
        case title
        case imageSet
        case rating
    }
    
    enum ImageSetKeys: String, CodingKey {
        case verticalPoster
    }

    enum VerticalPosterKeys: String, CodingKey {
        case w360
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let title = try container.decode(String.self, forKey: .title)
        
        let imageSetContainer = try container.nestedContainer(keyedBy: ImageSetKeys.self, forKey: .imageSet)
        let verticalPosterContainer = try imageSetContainer.nestedContainer(keyedBy: VerticalPosterKeys.self, forKey: .verticalPoster)
        
        let imagePath = try verticalPosterContainer.decode(String.self, forKey: .w360)
        let rating = try container.decode(Double.self, forKey: .rating)
        
        super.init(title: title, imagePath: imagePath, rating: rating)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
               
        var imageSetContainer = container.nestedContainer(keyedBy: ImageSetKeys.self, forKey: .imageSet)
        var verticalPosterContainer = imageSetContainer.nestedContainer(keyedBy: VerticalPosterKeys.self, forKey: .verticalPoster)
        
        try verticalPosterContainer.encode(imagePath, forKey: .w360)
        try container.encode(rating, forKey: .rating)
    }
}
