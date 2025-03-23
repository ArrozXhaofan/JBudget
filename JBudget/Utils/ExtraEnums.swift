//
//  EnumsExtra.swift
//  JBudget
//
//  Created by Jean Laura on 27/02/25.
//

import Foundation

enum GeoError: String, Error {
    case WithoutLocationData
    case CannotDecodeLocationData
}


enum AuthError: String, Error {
    case InvalidCredentials = ""
}
