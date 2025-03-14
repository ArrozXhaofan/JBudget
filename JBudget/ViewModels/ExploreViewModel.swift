//
//  ExploreViewModel.swift
//  JBudget
//
//  Created by Jean Laura on 28/02/25.
//

import Foundation
@preconcurrency import MapKit
import Observation
import _MapKit_SwiftUI
import CoreLocation


@Observable
final class ExploreViewModel {
    
    var myWishes : [Wish] = []
    var searchResults: [MKMapItem] = []
    
    var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    var myLocation: CLLocation = .init()
    var currentMKItemSelected : MKMapItem?
    
    //SERVICES
    private var mapsService: MapLocationService
    //USE CASES
    private var getWishesUseCase: GetAllWishUseCaseProtocol
    private var updateWishUseCase: UpdateWishUseCaseProtocol

    
    @MainActor
    init() {
        self.mapsService = MapLocationService()
        self.getWishesUseCase = GetAllWishUseCase()
        self.updateWishUseCase = UpdateWishUseCase()
        
        getWishes()
    }
    
    @MainActor
    func getWishes() {
        do {
            myWishes = try getWishesUseCase.getAllData()
        } catch let dataError as DataBaseError  {
            print(dataError.rawValue)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func addPlace(identifier: UUID, place: geoCoordinate) {
        do {
            try updateWishUseCase.addPlace(identifier: identifier, place: place)
        } catch let myError as DataBaseError {
            print(myError.rawValue)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func searchPlaceByName(_ name: String) {
        searchResults = []
        Task {
            let results = await mapsService.searchItemsByName(name: name)
            searchResults = results
            print(searchResults)
        }
    }
    
    
    func searchPlaceByCoordinate(_ coordinate: geoCoordinate) async -> MKMapItem? {
        do {
            return try await mapsService.findMKMapItem(for: coordinate)
            
        } catch let myError as GeoError {
            print(myError.rawValue)
            return nil
        } catch {
            print("Error inesperado")
            return nil
        }
    }
    
    
    func getMyLocation() {
        Task {
            myLocation = mapsService.gpsLocation
        }
    }
    
    func requestUseGps() {
        mapsService.startUpdatingLocation()
    }
    
    
    
}

