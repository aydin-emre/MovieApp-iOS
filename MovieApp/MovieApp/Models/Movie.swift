//
//  Movie.swift
//  MovieApp
//
//  Created by Emre on 31.12.2021.
//

import Foundation
import RealmSwift

class Movie: Object, Codable {

    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    @Persisted(primaryKey: true) var id: Int?
    let mediaType: MediaType
    let originalLanguage: String
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case mediaType = "media_type"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

}
