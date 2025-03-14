//
//  IncomeRepository.swift
//  JBudget
//
//  Created by Jean Laura on 3/02/25.
//

import Foundation
import SwiftData

@MainActor
protocol IncomeRepositoryProtocol {
    func getAllData() throws -> [Income]
    func insertData(_ data: Income) throws
    func updateData(_ identifier: UUID, name: String, value: Double) throws
    func deletedData(_ value: UUID) throws
}

final class IncomeRepository: IncomeRepositoryProtocol {
    
    let manager: ModelContext = Database.shared.context
    
    func getAllData() throws -> [Income] {
        let sort = SortDescriptor<Income>(\.dateCreated)
        let descriptor = FetchDescriptor(sortBy: [sort])
    
        
        
        do {
            let results = try manager.fetch(descriptor)
            return results
            
        } catch { throw DataBaseError.getDataFailed }
    }
    
    func insertData(_ data: Income) throws {
        do {
            manager.insert(data)
            try manager.save()
            
        } catch { throw DataBaseError.insertFailed }
    }
    
    func updateData(_ identifier: UUID, name: String, value: Double) throws {
        
        let predicate = #Predicate<Income> { $0.identifier == identifier }
        var descriptor = FetchDescriptor(predicate: predicate)
        descriptor.fetchLimit = 1
        
        guard let obj = try? manager.fetch(descriptor).first else {
            print("No se encontro el objeto")
            throw DataBaseError.notFound
        }
        
        do {
            obj.name = name
            obj.amount = value
            try manager.save()
            
        } catch { throw DataBaseError.updateFailed }
    }
    
    func deletedData(_ value: UUID) throws {
        
        let predicate = #Predicate<Income> {$0.identifier == value}
        
        do {
            try manager.delete(model: Income.self, where: predicate)
            try manager.save()
            
        } catch  { throw DataBaseError.deleteFailed }
    }
}
