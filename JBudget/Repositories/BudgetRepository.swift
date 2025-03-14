//
//  BudgetRepository.swift
//  JBudget
//
//  Created by Jean Laura on 3/02/25.
//

import Foundation
import SwiftData

@MainActor protocol BudgetRepositoryProtocol {
    func getAllData() throws -> [Budget]
    func getBudgetById(_ identifier: UUID) throws -> Budget
    func insertData(_ data: Budget) throws
    func updateData(_ identifier: UUID, name: String) throws
    func deletedData(_ value: UUID) throws
}

final class BudgetRepository: BudgetRepositoryProtocol {
    
    let manager: ModelContext
    
    init() {
        self.manager = Database.shared.context
    }
      
    
    
    func getAllData() throws -> [Budget] {
        let sort = SortDescriptor<Budget>(\.dateCreated)
        let descriptor = FetchDescriptor(sortBy: [sort])
        
        do {
            let results = try manager.fetch(descriptor)
            return results
            
        } catch { throw DataBaseError.getDataFailed }
    }
    
    func getBudgetById(_ identifier: UUID) throws -> Budget {
        let predicate = #Predicate<Budget> { $0.identifier == identifier }
        var descriptor = FetchDescriptor(predicate: predicate)
        descriptor.fetchLimit = 1
        
        guard let budget = try? manager.fetch(descriptor).first else {
            print("No se encontro el objeto")
            throw DataBaseError.notFound
        }
        
        return budget
    }
    
    func insertData(_ data: Budget) throws {
        do {
            manager.insert(data)
            try manager.save()
            
        } catch { throw DataBaseError.insertFailed }
    }
    
    func updateData(_ identifier: UUID, name: String) throws {
        
        let predicate = #Predicate<Budget> { $0.identifier == identifier }
        
        var descriptor = FetchDescriptor(predicate: predicate)
        descriptor.fetchLimit = 1
        
        guard let obj = try? manager.fetch(descriptor).first else {
            print("No se encontro el objeto")
            throw DataBaseError.notFound
        }
        
        do {
            obj.name = name
            try manager.save()
            
        } catch  { throw DataBaseError.updateFailed }
        
    }
    
    func deletedData(_ value: UUID) throws {
        
        let predicate = #Predicate<Budget> {$0.identifier == value}
        
        do {
            try manager.delete(model: Budget.self, where: predicate)
            try manager.save()
            
        } catch  { throw DataBaseError.deleteFailed }
    }
}
