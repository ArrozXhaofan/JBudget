//
//  UpdateIncomeUseCase.swift
//  JBudget
//
//  Created by Jean Laura on 26/02/25.
//

import Foundation

@MainActor 
protocol UpdateIncomesUseCaseProtocol {
     func update(identifier: UUID, name: String, value: Double) throws
}

struct UpdateIncomesUseCase: UpdateIncomesUseCaseProtocol {
    
    var repository: IncomeRepositoryProtocol = IncomeRepository()

    func update(identifier: UUID, name: String, value: Double) throws {
        try repository.updateData(identifier, name: name, value: value)
    }
    
}


