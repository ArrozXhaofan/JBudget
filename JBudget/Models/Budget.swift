//
//  Budget.swift
//  JBudget
//
//  Created by Jean Laura on 3/02/25.
//

import Foundation
import SwiftData

@Model
final class Budget: Identifiable, Hashable {
    
    @Attribute(.unique) var identifier: UUID
    var name: String
    var incomes: [Income]
    var expenses: [Expense]
    var dateCreated: Date = Date.now
    
    var resume: Double {
        return incomes.reduce(0) { $0 + $1.amount } -
        expenses.reduce(0) { $0 + $1.amount }
    }
    
    init(identifier: UUID = UUID(), name: String, incomes: [Income], expenses: [Expense]) {
        self.identifier = identifier
        self.name = name
        self.incomes = incomes
        self.expenses = expenses
    }
    
}


