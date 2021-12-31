//
//  MovieResponse.swift
//  MovieApp
//
//  Created by Emre on 31.12.2021.
//

import Foundation

struct MovieResponse: Codable {

    let statusCode: Int?
    let statusMessage: String?
    let success: Bool?
    let averageRating: Double?
    let backdropPath: String?
    let comments: [String: String?]?
    let createdBy: CreatedBy?
    let responseDescription: String?
    let id: Int?
    let iso3166_1: String?
    let iso639_1: String?
    let name: String?
    let objectIDS: [String: String?]?
    let page: Int?
    let posterPath: String?
    let welcomePublic: Bool?
    let results: [Movie]?
    let revenue, runtime: Int?
    let sortBy: String?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success
        case averageRating = "average_rating"
        case backdropPath = "backdrop_path"
        case comments
        case createdBy = "created_by"
        case responseDescription = "description"
        case id
        case iso3166_1 = "iso_3166_1"
        case iso639_1 = "iso_639_1"
        case name
        case objectIDS = "object_ids"
        case page
        case posterPath = "poster_path"
        case welcomePublic = "public"
        case results, revenue, runtime
        case sortBy = "sort_by"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

}
