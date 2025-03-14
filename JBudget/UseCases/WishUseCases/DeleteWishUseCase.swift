//
//  DeleteWishUseCase.swift
//  JBudget
//
//  Created by Jean Laura on 27/02/25.
//

import Foundation

@MainActor
protocol DeleteWishUseCaseProtocol {
    func delete(identifier: UUID) throws
}

struct DeleteWishUseCase: DeleteWishUseCaseProtocol {
    
    var repository: WishRepositoryProtocol = WishRepository()
    
    func delete(identifier: UUID) throws {
        try repository.deleteWish(identifier: identifier)
    }
    
}


