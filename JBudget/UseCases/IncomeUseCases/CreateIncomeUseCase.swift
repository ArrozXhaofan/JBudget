//
//  CreateIncomeUseCase.swift
//  JBudget
//
//  Created by Jean Laura on 26/02/25.
//

import Foundation

@MainActor
protocol CreateIncomesUseCaseProtocol {
    func insert(_ value: Income) throws
}

struct CreateIncomesUseCase: CreateIncomesUseCaseProtocol {
    
    var repository: IncomeRepositoryProtocol = IncomeRepository()

    func insert(_ value: Income) throws {
        try repository.insertData(value)
    }
    
}


