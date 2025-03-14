//
//  GetAllBudgetsUseCase.swift
//  JBudget
//
//  Created by Jean Laura on 26/02/25.
//

import Foundation

@MainActor
protocol GetAllBudgetsUseCaseProtocol {
    func getAllData() throws -> [Budget]
    func getBudgetById(_ identifier: UUID) throws -> Budget
}

struct GetAllBudgetsUseCase: GetAllBudgetsUseCaseProtocol {
    
    var repository: BudgetRepositoryProtocol = BudgetRepository()
    
    func getAllData() throws -> [Budget] {
        try repository.getAllData()
    }
    
    func getBudgetById(_ identifier: UUID) throws -> Budget {
        try repository.getBudgetById(identifier)
    }
    
}


