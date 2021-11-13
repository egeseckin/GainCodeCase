//
//  ContentView.swift
//  GainCodeCase
//
//  Created by Ege Seçkin on 12.11.2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var movieData: MoviesData
    @ObservedObject var showData: ShowsData
    @ObservedObject var latestTvShowData: LatestTvShowsData
    
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.black.ignoresSafeArea()
                VStack(alignment: .leading) {
                    ZStack(alignment: .bottom){
                        if latestTvShowData.latestTvShows.value(forKey: "poster_path") as? String != nil{
                            let poster = latestTvShowData.latestTvShows.value(forKey: "poster_path") as? String
                            
                            let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(poster!)")!
                            let imageData = try! Data(contentsOf: imageUrl)
                            
                            URLImage(imageData: imageData)
                                .ignoresSafeArea()
                                .aspectRatio(contentMode: .fill)
                            
                            
                        }else{
                            
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .cornerRadius(8)
                                .shadow(radius: 4)
                                .opacity(0.4)
                                .ignoresSafeArea()
                        }
                        HStack(alignment:.bottom, spacing: 130){
                            
                            VStack(alignment:.leading, spacing: 2){
                                
                                Text(latestTvShowData.latestTvShows.value(forKey: "name") as? String ?? "No Name")
                                    .font(.headline)
                                    .padding(.horizontal)
                                    .foregroundColor(.white)
                                Text("TV Show")
                                    .font(.headline)
                                    .padding(.horizontal)
                                    .foregroundColor(.gray)
                                Text("Latest content")
                                    .font(.caption)
                                    .padding(.horizontal)
                                    .foregroundColor(.red)
                            }
                            
                            Button("Watch"){}
                            .font(.subheadline)
                            .frame(width: 70, height: 0)
                            .padding()
                            .foregroundColor(.black)
                            .background(Color.green)
                            .cornerRadius(30)
                            .padding(.horizontal)
                            
                            
                        }
                    }
                    
                    //TV Shows
                    Text("Popular TV Shows")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top, spacing: 16) {
                            ForEach(showData.shows ?? [Show](), id: \.id) { show in
                                
                                NavigationLink(destination: ShowDetailView()) {
                                    
                                    let imageUrl = URL(string: show.showPosterURL)!
                                    let imageData = try! Data(contentsOf: imageUrl)
                                    
                                    URLImage(imageData: imageData)
                                    
                                }
                                
                            }
                        }
                    }
                    
                    // Movies
                    Text("Popular Movies")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top, spacing: 16) {
                            ForEach(movieData.movies ?? [Movie](), id: \.id) { movie in
                                
                                NavigationLink(destination: MovieDetailView()) {
                                    
                                    let imageUrl = URL(string: movie.moviePosterURL)!
                                    let imageData = try! Data(contentsOf: imageUrl)
                                    
                                    URLImage(imageData: imageData)
                                    
                                }
                            }
                        }
                    }
                    
                }
                
            }
        }
        .onAppear{
            latestTvShowData.getLatestTvShows()
            showData.getAllShows()
            movieData.getAllMovies()
            sleep(1)
        }
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(movieData: MoviesData(), showData: ShowsData(), latestTvShowData: LatestTvShowsData())
    }
}
