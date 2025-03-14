//
//  DeleteExpenseUseCase.swift
//  JBudget
//
//  Created by Jean Laura on 26/02/25.
//

import Foundation

@MainActor
protocol DeleteExpenseUseCaseProtocol {
    func delete(identifier: UUID) throws
}

struct DeleteExpenseUseCase: DeleteExpenseUseCaseProtocol {
    
    var repository: ExpenseRepositoryProtocol = ExpenseRepository()

    func delete(identifier: UUID) throws {
        try repository.deletedData(identifier)
    }
    
}


