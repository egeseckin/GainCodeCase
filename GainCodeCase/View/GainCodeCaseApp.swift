//
//  GainCodeCaseApp.swift
//  GainCodeCase
//
//  Created by Ege Seçkin on 12.11.2021.
//

import SwiftUI

@main
struct GainCodeCaseApp: App {
    
    @StateObject var moviedata = MoviesData()
    @StateObject var showdata = ShowsData()
    @StateObject var latestTvShowdata = LatestTvShowsData()
    
    var body: some Scene {
        WindowGroup {
            ContentView(movieData: moviedata, showData: showdata, latestTvShowData: latestTvShowdata)
        }
    }
    
}
