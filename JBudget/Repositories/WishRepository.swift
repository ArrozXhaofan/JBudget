//
//  WishRepository.swift
//  JBudget
//
//  Created by Jean Laura on 27/02/25.
//

import Foundation
import SwiftData

@MainActor protocol WishRepositoryProtocol {
    func getAllData() throws -> [Wish]
    func createWish(_ wish: Wish) throws
    func updateWish(identifier: UUID, newValue: Wish) throws
    func addPlace(identifier: UUID, place: geoCoordinate) throws
    func updateWishObligatoryValues(identifier: UUID, name: String, amount: Double) throws
    func deleteWish(identifier: UUID) throws
}


final class WishRepository: WishRepositoryProtocol {
    
    let manager: ModelContext = Database.shared.context
    
    func getAllData() throws -> [Wish] {
        
        let sortDescriptor = SortDescriptor(\Wish.name)
        let descriptor = FetchDescriptor(sortBy: [sortDescriptor])
        
        do {
            let data = try manager.fetch(descriptor)
            return data
            
        } catch { throw DataBaseError.getDataFailed }
    }
    
    func createWish(_ wish: Wish) throws {
        
        do {
            manager.insert(wish)
            try manager.save()
            
        } catch  { throw DataBaseError.insertFailed }
    }
    
    func updateWish(identifier: UUID, newValue: Wish) throws {
        
        let predicate = #Predicate<Wish>{$0.identifier == identifier}
        var descriptor = FetchDescriptor(predicate: predicate)
        descriptor.fetchLimit = 1
        
        guard let item = try? manager.fetch(descriptor).first else {
            throw DataBaseError.notFound
        }
        
        do {
            item.name = newValue.name
            item.descriptionWish = newValue.descriptionWish
            item.amount = newValue.amount
            item.minAmount = newValue.minAmount
            item.maxAmount = newValue.maxAmount
            item.place = newValue.place
            try manager.save()
            
        } catch { throw DataBaseError.updateFailed }
    }
    
   
    
    func addPlace(identifier: UUID, place: geoCoordinate) throws {
        
        let predicate = #Predicate<Wish>{$0.identifier == identifier}
        var descriptor = FetchDescriptor(predicate: predicate)
        descriptor.fetchLimit = 1
        
        guard let item = try? manager.fetch(descriptor).first else {
            throw DataBaseError.notFound
        }
        
        do {
            item.place = place
            try manager.save()
            
        } catch { throw DataBaseError.updateFailed }
    }
    
    func updateWishObligatoryValues(identifier: UUID, name: String, amount: Double) throws {
        
        let predicate = #Predicate<Wish>{$0.identifier == identifier}
        var descriptor = FetchDescriptor(predicate: predicate)
        descriptor.fetchLimit = 1
        
        guard let item = try? manager.fetch(descriptor).first else {
            throw DataBaseError.notFound
        }
        
        do {
            item.name = name
            item.amount = amount
            try manager.save()
            
        } catch { throw DataBaseError.updateFailed }
    }
    
    func deleteWish(identifier: UUID) throws {
        
        let predicate = #Predicate<Wish>{$0.identifier == identifier}
        var descriptor = FetchDescriptor(predicate: predicate)
        descriptor.fetchLimit = 1
        
        guard let item = try? manager.fetch(descriptor).first else {
            throw DataBaseError.notFound
        }
        
        do {
            manager.delete(item)
            try manager.save()
            
        } catch { throw DataBaseError.deleteFailed }
    }
}
