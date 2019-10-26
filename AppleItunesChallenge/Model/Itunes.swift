//
//  Itunes.swift
//  AppleItunesChallenge
//
//  Created by Kinney Kare on 10/23/19.
//  Copyright © 2019 Kinney Kare. All rights reserved.
//

import Foundation

//this is where we create our data model

/*
 the response is a structure of the other structs maps to the information to the response that we get from our API.
 */

struct NewMusicResponse: Decodable {
    var response: Feed
}

struct Feed: Decodable {
    var feed: [TheResults]
}

struct TheResults: Decodable {
    var artistName: String
    var artworkUrl100: String
    var kind: String 
    var name: String
    var releaseDate: String
}

struct SetupImage {
    let imageName: String
    let language: String
}
