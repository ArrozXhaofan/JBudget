//
//  UpdateWishUseCase.swift
//  JBudget
//
//  Created by Jean Laura on 27/02/25.
//

import Foundation

@MainActor
protocol UpdateWishUseCaseProtocol {
    func update(identifier: UUID, value: Wish) throws
    func updateWishObligatoryValues(identifier: UUID, name: String, amount: Double) throws
    func addPlace(identifier: UUID, place: geoCoordinate) throws
}

struct UpdateWishUseCase: UpdateWishUseCaseProtocol {
    
    var repository : WishRepositoryProtocol = WishRepository()
    
    func update(identifier: UUID, value: Wish) throws {
        try repository.updateWish(identifier: identifier, newValue: value)
    }
    
    func addPlace(identifier: UUID, place: geoCoordinate) throws {
        try repository.addPlace(identifier: identifier, place: place)
    }
    
    
    func updateWishObligatoryValues(identifier: UUID, name: String, amount: Double) throws {
        try repository.updateWishObligatoryValues(identifier: identifier, name: name, amount: amount)
    }
}
