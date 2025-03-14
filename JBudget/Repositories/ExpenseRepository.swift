//
//  ExpenseRepository.swift
//  JBudget
//
//  Created by Jean Laura on 3/02/25.
//

import Foundation
import SwiftData

@MainActor protocol ExpenseRepositoryProtocol {
    func getAllData() throws -> [Expense]
    func insertData(_ data: Expense) throws
    func updateData(_ identifier: UUID, name: String, value: Double) throws
    func deletedData(_ value: UUID) throws
}

final class ExpenseRepository: ExpenseRepositoryProtocol {
    
    let manager: ModelContext = Database.shared.context
    
    func getAllData() throws -> [Expense] {
        let sort = SortDescriptor<Expense>(\.dateCreated)
        let descriptor = FetchDescriptor(sortBy: [sort])
        let results = try manager.fetch(descriptor)
        return results
    }
    
    
    
    func insertData(_ data: Expense) throws {
        manager.insert(data)
        try manager.save()
    }
    
    func updateData(_ identifier: UUID, name: String, value: Double) throws {
        
        let predicate = #Predicate<Expense> { $0.identifier == identifier }
        
        var descriptor = FetchDescriptor(predicate: predicate)
        descriptor.fetchLimit = 1
        
        guard let obj = try? manager.fetch(descriptor).first else {
            print("No se encontro el objeto")
            return
        }
        
        obj.name = name
        obj.amount = value
        try manager.save()
    }
    
    func deletedData(_ value: UUID) throws {
        
        let predicate = #Predicate<Expense> {$0.identifier == value}
        
        try manager.delete(model: Expense.self, where: predicate)
        try manager.save()
    }
}
