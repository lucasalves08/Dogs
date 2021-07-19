//
//  BreedListResponse.swift
//  Dogs
//
//  Created by Lucas Alves Dos Santos on 18/07/21.
//

import Foundation

struct BreedListResponse: Codable {
    let breeds: [String: [String]]

    enum CodingKeys: String, CodingKey {
        case breeds = "message"
    }
}
