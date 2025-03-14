//
//  DeleteIncomeUseCase.swift
//  JBudget
//
//  Created by Jean Laura on 26/02/25.
//

import Foundation

@MainActor 
protocol DeleteIncomesUseCaseProtocol {
    func delete(_ identifier: UUID) throws
}

struct DeleteIncomesUseCase: DeleteIncomesUseCaseProtocol {
    
    var repository: IncomeRepositoryProtocol = IncomeRepository()

    func delete(_ identifier: UUID) throws {
        try repository.deletedData(identifier)
    }
    
}


