//
//  Rating.swift
//  MovieDatabaseApp
//
//  Created by AdminFS on 21/06/23.
//

import Foundation

// MARK: - Rating
struct Rating: Decodable {
    let source: String?
    let value: String?

    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}
