//
//  NetworkConstant.swift
//  AlfagiftTakeHome
//
//  Created by Rizky Maulana on 27/02/23.
//

import Foundation

enum MovieBaseURL {
    static let baseURL =  "https://api.themoviedb.org/3/"
    static let movie = "movie/"
    static let imageURL = "https://image.tmdb.org/t/p/original"
    static let apiKey = "?api_key=783a4485ba37ff63e4a463f044195611"
    static let appendToResponse = "&append_to_response="
}

enum MovieRequest: String {
    case reviews = "reviews"
    case videos = "videos"
}
