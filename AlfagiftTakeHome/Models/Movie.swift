//
//  Headlines.swift
//  AlfagiftTakeHome
//
//  Created by Rizky Maulana on 26/02/23.
//

import Foundation

struct MovieResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int
}

struct Movie: Codable {
    let id: Int
    let title: String
    let posterPath: String
}

struct MovieDetail: Codable {
    let adult: Bool
    let backdropPath: String
    let budget: Int
    let homepage: String
    let id: Int
    let imdbId: String
    let originalTitle, overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let revenue, runtime: Int
    let status, tagline, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    let videos: VideoResponse
    let reviews: ReviewResponse
}

struct Video: Codable {
    let id: String
    let name: String
    let key: String
}

struct VideoResponse: Codable {
    let results:[Video]
}

struct Review: Codable {
    let author: String
    let content, createdAt, id, updatedAt: String
    let url: String
}

struct ReviewResponse: Codable {
    let page: Int
    let results: [Review]
    let totalPages, totalResults: Int
}
