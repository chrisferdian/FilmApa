//
//  ResponseVideos.swift
//  FIlmApa
//
//  Created by TMLI IT DEV on 18/12/20.
//

import Foundation
// MARK: - ResponseVideos
struct ResponseVideos: Codable {
    let id: Int
    let results: [MovieVideo]
}
// MARK: - Result
struct MovieVideo: Codable {
    let id, iso639_1, iso3166_1, key: String
    let name, site: String
    let size: Int
    let type: String

    enum CodingKeys: String, CodingKey {
        case id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case key, name, site, size, type
    }
}
