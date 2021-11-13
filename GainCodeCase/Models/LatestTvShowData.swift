//
//  LatestTvShowData.swift
//  GainCodeCase
//
//  Created by Ege Seçkin on 13.11.2021.
//

import Foundation
import Alamofire

var urlValue = NSDictionary()

struct LatestShowsResponse: Decodable{
    
    let latestshows: [LatestShow]
    
}

struct LatestShow: Decodable, Identifiable {
    
    var id: Int?
    var name: String?
    var poster_path: String?
    
    var posterURL: String{
        return String("https://image.tmdb.org/t/p/w500\(poster_path ?? " ")")
    }
    
}


class LatestTvShowsData: ObservableObject {
    
    @Published var latestTvShows = NSDictionary()
   // @Published var datadecoded: NSDictionary? = NSDictionary()
    
    func getLatestTvShows() {
        AF.request("https://api.themoviedb.org/3/tv/latest?api_key=0921a11ff74eb51180882534314e79af&language=en-US").responseJSON{(result) in
            self.latestTvShows = (result.value as! NSDictionary)
            urlValue = self.latestTvShows
        }
        
    }
}


