//
//  IncomeRepository.swift
//  JBudget
//
//  Created by Jean Laura on 2/02/25.
//

import Foundation
import SwiftData

enum DataBaseError: String, Error, Hashable {
    case notFound = "Elemento no encontrado."
    case insertFailed = "Error al insertar el elemento"
    case updateFailed = "Error al actualizar el elemento"
    case deleteFailed = "Error al eliminar el elemento"
    case getDataFailed = "Error al obtener los datos"
}

protocol DataBaseProtocol {
    static func setup(inDisk: Bool) -> ModelContainer
}

final class Database: DataBaseProtocol {
    
    @MainActor
    static let shared = Database()
    private let database: ModelContainer = setup(inDisk: true)
    
    @MainActor
    var context: ModelContext {
        database.mainContext
    }
    
    static func setup(inDisk: Bool) -> ModelContainer {
        
        let schema = Schema([Income.self,Budget.self, Expense.self, Wish.self ])
        let setting = ModelConfiguration(isStoredInMemoryOnly: !inDisk)
        
        do {
            let container = try ModelContainer(for: schema, configurations: [setting])
            return container
            
        } catch  { fatalError("Error setting up the database") }
    }
    
}


