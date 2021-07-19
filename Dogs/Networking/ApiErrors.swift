//
//  ApiErrors.swift
//  Dogs
//
//  Created by Lucas Alves Dos Santos on 19/07/21.
//

import Foundation

enum ApiErrors: Error, Equatable {
    case missingData
    case requetFailed

    var titleAndMessage: (String, String) {
        switch self {
        case .missingData:
            return("Missing Data", "Request data is nil.")
        case .requetFailed:
            return("Request Failed", "Something went wrong.")
        }
    }
}
