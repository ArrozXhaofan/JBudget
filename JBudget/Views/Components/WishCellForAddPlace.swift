//
//  WishCellForAddPlace.swift
//  JBudget
//
//  Created by Jeanpiere Laura on 13/03/25.
//

import SwiftUI
import MapKit

struct WishCellForAddPlace: View {
    
    @Binding var manager: ExploreViewModel
    var item: Wish
    
    @State private var makItem: MKMapItem?
    
    
    var body: some View {
        HStack {
            Button {
                Task {
                    guard let item = await manager.searchPlaceByCoordinate(item.place!) else {
                        return
                    }
                    withAnimation(.easeInOut(duration: 1)) {
                        manager.cameraPosition = .item(item)
                    }
                }
                
            } label: {
                
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.system(size: 17))
                    Text(makItem?.placemark.name ?? "Sin ubicación")
                        .font(.footnote)
                        .foregroundStyle(.lightGrayVercel)
                }
            }

            Spacer()
            
            Button {
                if let mkItem = manager.currentMKItemSelected {
                    manager.addPlace(identifier: item.identifier,
                                     place: mkItem.toGeoCoordinate())
                }
                
            } label: {
                Image(systemName: item.place != nil ? "pencil" : "plus")
                    .foregroundStyle(.blue)
                    .opacity(manager.currentMKItemSelected != nil ? 1 : 0.3)
            }
            .disabled(manager.currentMKItemSelected == nil)
        }
        .padding(.horizontal)
        .frame(height: 50)
        .onAppear {
            Task {
                if let coordinate = item.place {
                    makItem = await manager.searchPlaceByCoordinate(coordinate)
                }
            }
        }
        .onChange(of: item.place) { oldValue, newValue in
            Task {
                if let coordinate = item.place {
                    makItem = await manager.searchPlaceByCoordinate(coordinate)
                }
            }
        }
        
    }
}

#Preview {
    WishCellForAddPlace(manager: .constant(ExploreViewModel()),
                        item: wishPrevData)
}
