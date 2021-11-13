//
//  ShowsData.swift
//  GainCodeCase
//
//  Created by Ege Seçkin on 13.11.2021.
//

import Foundation

struct ShowsResponse: Decodable{
    
    let shows: [Show]
    
    private enum CodingKeys: String, CodingKey {
        case shows = "results"
    }
    
}

struct Show: Decodable, Identifiable {
    
    var id: Int?
    var name: String?
    var poster_path: String?
    var vote_average: Double?
    var overview: String?
    
    var showPosterURL: String{
        return String("https://image.tmdb.org/t/p/w500\(poster_path ?? " ")")
    }
    
}


class ShowsData: ObservableObject {
    
    @Published var shows: [Show]? = [Show]()
    
    func getAllShows() {
        guard let url = URL(string: "https://api.themoviedb.org/3/tv/popular?api_key=0921a11ff74eb51180882534314e79af&language=en-US") else {
            fatalError("Invalid URL")
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            let showResponse = try? JSONDecoder().decode(ShowsResponse.self, from: data)
            if let showResponse = showResponse {
                DispatchQueue.main.async {
                    self.shows = showResponse.shows
                }
            }
        }.resume()
    }
}

