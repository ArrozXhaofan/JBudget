//
//  UpdateBudgetUseCase.swift
//  JBudget
//
//  Created by Jean Laura on 26/02/25.
//

import Foundation

@MainActor
protocol UpdateBudgetsUseCaseProtocol {
    func update(identifier: UUID, newTitle: String) throws
}

struct UpdateBudgetsUseCase: UpdateBudgetsUseCaseProtocol {
    
    var repository: BudgetRepositoryProtocol = BudgetRepository()
    
    func update(identifier: UUID, newTitle: String) throws {
        try repository.updateData(identifier, name: newTitle)
    }
    
}


