//
//  ItunesRequest.swift
//  AppleItunesChallenge
//
//  Created by Kinney Kare on 10/23/19.
//  Copyright © 2019 Kinney Kare. All rights reserved.
//

import Foundation


//This is how we will access the response from the API.

//In here we need to configure all that we would like to access.

struct ItunesRequest {
    
    var resourceURL: URL
    init() {
    
    let feedType = "new-releases"
    
   let destinationURL = "https://rss.itunes.apple.com/api/v1/us/apple-music/\(feedType)/all/10/explicit.json"
    
    guard let resourceURL = URL(string: destinationURL) else {fatalError()}
    
        self.resourceURL = resourceURL
    }
    
    func getAppleMusicData (compleation: @escaping(Result<[TheResults], AppleMusicError>) ->Void) {
        
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            
            guard let jsonData = data else {
                compleation(.failure(.noDataAvailable))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let newMusicResponse = try decoder.decode(NewMusicResponse.self, from: jsonData)
                let results = newMusicResponse.response.feed
                compleation(.success(results))
            }catch{
                compleation(.failure(.canNotProcessData))
            }
            
        }
        dataTask.resume()
    }
    
}

enum AppleMusicError: Error {
    case noDataAvailable
    case canNotProcessData
}
