//
//  GetAllIncomesUseCase.swift
//  JBudget
//
//  Created by Jean Laura on 26/02/25.
//

import Foundation

@MainActor
protocol GetAllIncomesUseCaseProtocol {
    func getAllIncomes() throws -> [Income]
}

struct GetAllIncomesUseCase: GetAllIncomesUseCaseProtocol {
    
    var repository: IncomeRepositoryProtocol = IncomeRepository()
    
    func getAllIncomes() throws -> [Income] {
        try repository.getAllData()
    }
    
}


