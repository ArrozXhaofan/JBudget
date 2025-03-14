//
//  GetAllExpensesUseCase.swift
//  JBudget
//
//  Created by Jean Laura on 26/02/25.
//

import Foundation

@MainActor
protocol GetAllExpensesUseCaseProtocol {
    func getAllData() throws -> [Expense]
}

struct GetAllExpensesUseCase: GetAllExpensesUseCaseProtocol {
    
    var repository: ExpenseRepositoryProtocol = ExpenseRepository()
    
    func getAllData() throws -> [Expense] {
        try repository.getAllData()
    }
    
}


