//
//  Movies.swift
//  GainCodeCase
//
//  Created by Ege Seçkin on 12.11.2021.
//

import Foundation

struct MoviesResponse: Decodable{
    
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
    
}

struct Movie: Decodable, Identifiable {
    
    var id: Int?
    var title: String?
    var poster_path: String?
    var vote_average: Double?
    var overview: String?
    
    var moviePosterURL: String{
        return String( "https://image.tmdb.org/t/p/w500\(poster_path ?? " ")")
    }
    
}


class MoviesData: ObservableObject {
    
    @Published var movies: [Movie]? = [Movie]()
    
    func getAllMovies() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=0921a11ff74eb51180882534314e79af&language=en-US") else {
            fatalError("Invalid URL")
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                return
            }
             
            let movieResponse = try? JSONDecoder().decode(MoviesResponse.self, from: data)
            if let movieResponse = movieResponse {
                DispatchQueue.main.async {
                    self.movies = movieResponse.movies
                }
            }
        }.resume()
    }
}
