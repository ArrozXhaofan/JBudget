//
//  Wish.swift
//  JBudget
//
//  Created by Jean Laura on 27/02/25.
//

import Foundation
import SwiftData
import MapKit

@Model
final class Wish: Hashable {
    
    @Attribute(.unique) var identifier: UUID
    var name: String
    var descriptionWish: String?
    var amount: Double
    var minAmount: Double?
    var maxAmount: Double?
    var place: geoCoordinate?
    
    init(identifier: UUID = UUID(),
         name: String,
         descriptionWish: String?,
         amount: Double,
         minAmount: Double?,
         maxAmount: Double?,
         place: geoCoordinate?) {
        self.identifier = identifier
        self.name = name
        self.descriptionWish = descriptionWish
        self.amount = amount
        self.minAmount = minAmount
        self.maxAmount = maxAmount
        self.place = place
    }
}


