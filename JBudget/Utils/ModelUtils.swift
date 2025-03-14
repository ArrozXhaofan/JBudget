//
//  ModelUtils.swift
//  JBudget
//
//  Created by Jean Laura on 3/02/25.
//

import Foundation
import SwiftUI
import MapKit

extension Budget {
    func toPrevCell() -> DataCellModel {
        .init(id: self.identifier, name: self.name, value: self.resume, type: .budget)
    }
    
}

extension Income {
    func toPrevCell() -> DataCellModel {
        .init(id: self.identifier, name: self.name, value: self.amount, type: .income)
    }
}

extension Expense {
    func toPrevCell() -> DataCellModel {
        .init(id: self.identifier, name: self.name, value: self.amount, type: .expense)
    }
}

extension Wish {
    func toPrevCell() -> DataCellModel {
        .init(id: self.identifier, name: self.name, value: self.amount, type: .wishItem)
    }
}

extension Color {
    static var randomPreset: Color {
        let colors: [Color] = [.red, .blue, .green, .yellow, .purple, .orange, .pink]
        return colors.randomElement() ?? .black
    }
}

extension String {
    func stringToDouble() -> Double? {
        if self == "" {
            return nil
            
        } else {
            guard let value = Double(self) else {
                return nil
            }
            return value
        }
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}


extension geoCoordinate {
    func convertedToCLLocationCoordinate2D() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.lat, longitude: self.lng)
    }
}

extension MKMapItem {
    
    func toGeoCoordinate() -> geoCoordinate {
        return .init(lat: self.placemark.coordinate.latitude, lng: self.placemark.coordinate.longitude)
    }
    
    
    static func sampleMapItem() -> MKMapItem {
        let coordinate = CLLocationCoordinate2D(latitude: 41.25796020, longitude: -95.97317070)
        
        let placemark = MKPlacemark(
            coordinate: coordinate,
            addressDictionary: [
                "Street": "3932 Farnam St",
                "City": "Omaha",
                "State": "NE",
                "ZIP": "68131",
                "Country": "United States"
            ]
        )
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Mula Mexican Kitchen & Tequileria"
        mapItem.phoneNumber = "+1 (402) 315-9051"
        mapItem.url = URL(string: "http://mulaomaha.com")
        
        return mapItem
    }
}

