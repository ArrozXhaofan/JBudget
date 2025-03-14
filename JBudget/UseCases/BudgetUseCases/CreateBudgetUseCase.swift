//
//  CreateBudgetUseCase.swift
//  JBudget
//
//  Created by Jean Laura on 26/02/25.
//

import Foundation

@MainActor
protocol CreateBudgetUseCaseProtocol {
    func newBudget(value: Budget) throws
}

struct CreateBudgetUseCase: CreateBudgetUseCaseProtocol {
    
    var repository: BudgetRepositoryProtocol = BudgetRepository()
    
    func newBudget(value: Budget) throws {
        try repository.insertData(value)
    }
    
}


