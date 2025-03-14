//
//  DeleteBudgetUseCase.swift
//  JBudget
//
//  Created by Jean Laura on 26/02/25.
//

import Foundation

@MainActor
protocol DeleteBudgetsUseCaseProtocol {
     func delete(_ identifier: UUID) throws
}

struct DeleteBudgetsUseCase: DeleteBudgetsUseCaseProtocol {

    var repository: BudgetRepositoryProtocol = BudgetRepository()

    func delete(_ identifier: UUID) throws {
        try repository.deletedData(identifier)
    }
    
}



