//
//  CreatedBy.swift
//  MovieApp
//
//  Created by Emre on 31.12.2021.
//

import Foundation

struct CreatedBy: Codable {

    let gravatarHash, id, name, username: String

    enum CodingKeys: String, CodingKey {
        case gravatarHash = "gravatar_hash"
        case id, name, username
    }

}
