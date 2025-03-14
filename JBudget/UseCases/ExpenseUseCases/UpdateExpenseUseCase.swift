//
//  UpdateExpenseUseCase.swift
//  JBudget
//
//  Created by Jean Laura on 26/02/25.
//

import Foundation

@MainActor
protocol UpdateExpenseUseCaseProtocol {
    func update(identifier: UUID, name: String, value: Double) throws
}

struct UpdateExpenseUseCase: UpdateExpenseUseCaseProtocol {
    
    var repository: ExpenseRepositoryProtocol = ExpenseRepository()

    func update(identifier: UUID, name: String, value: Double) throws {
        try repository.updateData(identifier, name: name, value: value)
    }
    
}


