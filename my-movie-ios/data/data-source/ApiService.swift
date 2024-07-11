//
//  ApiService.swift
//  my-movie-ios
//
//  Created by wira on 11/07/24.
//

import Foundation

class ApiService {
    private let baseUrl = "https://streaming-availability.p.rapidapi.com/shows/search/title"
    private let apiKey = "d4a30a47dcmsh619410b357ba35bp19b41ejsn02359b5166d6"

    func fetchMovies(query: String, completion: @escaping (Result<[MovieResponse], Error>) -> Void) {
        let fullUrlString = "\(baseUrl)?country=us&title=\(query)&series_granularity=show&show_type=movie&output_language=en"
        guard let url = URL(string: fullUrlString) else {
            completion(.failure(
                NSError(
                    domain: "",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]
                )
            ))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("streaming-availability.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        request.addValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(
                    NSError(
                        domain: "",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "Failed to load movies"]
                    )
                ))
                return
            }

            do {
                let decoder = JSONDecoder()
                let movies = try decoder.decode([MovieResponse].self, from: data)
                completion(.success(movies))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
