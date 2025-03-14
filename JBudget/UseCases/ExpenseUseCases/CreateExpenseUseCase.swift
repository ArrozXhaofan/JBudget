//
//  CreateExpenseUseCase.swift
//  JBudget
//
//  Created by Jean Laura on 26/02/25.
//

import Foundation

@MainActor
protocol CreateExpenseUseCaseProtocol {
    func insert(_ data: Expense) throws
}

struct CreateExpenseUseCase: CreateExpenseUseCaseProtocol {
    
    var repository: ExpenseRepositoryProtocol = ExpenseRepository()

    func insert(_ data: Expense) throws {
        try repository.insertData(data)
    }
    
}


