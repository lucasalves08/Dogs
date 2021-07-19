//
//  DogImageResponse.swift
//  Dogs
//
//  Created by Lucas Alves Dos Santos on 18/07/21.
//

import Foundation

struct DogImageResponse: Codable {
    let urlString: String

    enum CodingKeys: String, CodingKey {
        case urlString = "message"
    }
}
