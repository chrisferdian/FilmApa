//
//  GenresResponse.swift
//  FIlmApa
//
//  Created by TMLI IT DEV on 16/12/20.
//

import Foundation

// MARK: - GenresResponse
struct GenresResponse: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
