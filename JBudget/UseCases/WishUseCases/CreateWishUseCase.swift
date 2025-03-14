//
//  CreateWishUseCase.swift
//  JBudget
//
//  Created by Jean Laura on 27/02/25.
//

import Foundation

@MainActor 
protocol CreateWishUseCaseProtocol {
    func insert(value: Wish) throws
}

struct CreateWishUseCase: CreateWishUseCaseProtocol {
    
    var repository : WishRepositoryProtocol = WishRepository()

    func insert(value: Wish) throws {
        try repository.createWish(value)
    }
}


