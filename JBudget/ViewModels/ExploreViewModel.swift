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
@MainActor final class ExploreViewModel {
    
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
    
    
    init() {
        self.mapsService = MapLocationService()
        self.getWishesUseCase = GetAllWishUseCase()
        self.updateWishUseCase = UpdateWishUseCase()
        
        getWishes()
    }
    
    func getWishes() {
        do {
            myWishes = try getWishesUseCase.getAllData()
        } catch let dataError as DataBaseError  {
            print(dataError.rawValue)
        } catch {
            print(error.localizedDescription)
        }
    }
    
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
    
    
    func searchPlaceByCoordinate(_ coordinate: geoCoordinate) -> MKMapItem? {
        
        var data: MKMapItem? = nil
        
        Task {
            do {
                let preData = try await mapsService.findMKMapItem(for: coordinate)
                data = preData
                
            } catch let myError as GeoError {
                print(myError.rawValue)
            } catch {
                print("Error inesperado")
            }
        }
        
        return data
        
    }
    
    
    func getMyLocation() {
        myLocation = mapsService.gpsLocation
    }
    
    func requestUseGps() {
        mapsService.startUpdatingLocation()
    }
    
}

