//
//  GetAllWishUseCase.swift
//  JBudget
//
//  Created by Jean Laura on 27/02/25.
//

import Foundation

@MainActor
protocol GetAllWishUseCaseProtocol {
     func getAllData() throws -> [Wish]
}

struct GetAllWishUseCase: GetAllWishUseCaseProtocol {
    
    var repository: WishRepositoryProtocol = WishRepository()
    
    func getAllData() throws -> [Wish] {
        try repository.getAllData()
    }
    
}


