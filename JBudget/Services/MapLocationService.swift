//
//  MapLocationService.swift
//  JBudget
//
//  Created by Jean Laura on 28/02/25.
//

import Foundation
import MapKit
import CoreLocation

@Observable
final class MapLocationService: NSObject, CLLocationManagerDelegate {
    
    var gpsLocation: CLLocation = .init()
    
    private var locationManager: CLLocationManager = .init()
        
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    func searchItemsByName(name: String) async -> [MKMapItem] {
        
        if name == "" {
            print("Escriba algo para buscar")
            return []
        }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = name
        request.resultTypes = .pointOfInterest
        request.region = MKCoordinateRegion(center: gpsLocation.coordinate,
                                            latitudinalMeters: 50000,
                                            longitudinalMeters: 50000)
        
        let search = MKLocalSearch(request: request)
        
        do {
            let preData = try await search.start()
            let data = preData.mapItems
            
            return data
            
        } catch  {
            print("Error al buscar")
            return []
        }
    }
    
    func findMKMapItem(for coordinate: geoCoordinate) async throws -> MKMapItem {
        
        let request = CLGeocoder()
        let coordinate = CLLocation(latitude: coordinate.lat,
                                    longitude: coordinate.lng)
        
        do {
            let item = try await request.reverseGeocodeLocation(coordinate)
            
            guard let place = item.first else {
                throw GeoError.WithoutLocationData
            }
            
            return MKMapItem(placemark: .init(placemark: place))
            
        } catch {
            throw GeoError.CannotDecodeLocationData
        }
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {
            print("Error al usar la localización")
            return
        }
        gpsLocation = location
    }
}


