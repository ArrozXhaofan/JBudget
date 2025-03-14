//
//  Item.swift
//  JBudget
//
//  Created by Jean Laura on 2/02/25.
//

import Foundation
import SwiftData

@Model
final class Income: Identifiable, Hashable {
    
    @Attribute(.unique) var identifier: UUID
    var name: String
    var amount: Double
    var dateCreated: Date = Date.now
    
    init(identifier: UUID = UUID(), name: String, amount: Double) {
        self.name = name
        self.amount = amount
        self.identifier = identifier
    }
    
}


