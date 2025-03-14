//
//  ExploreViwe.swift
//  JBudget
//
//  Created by Jean Laura on 28/02/25.
//

import SwiftUI
import MapKit

struct ExploreView: View {
    
    @State var vm = ExploreViewModel()
    
    @FocusState private var isFocused: Bool
    @State private var txtSearch = ""
    
    @State private var isSheetOn = false
    
    private var myRadiiSheet: RectangleCornerRadii {
        let carnii: CGFloat = 10
        return .init(topLeading: carnii, topTrailing: carnii)
    }
    
    var body: some View {
        NavigationStack {
            
            VStack {
                
                ZStack(alignment: .center) {
                    
                    VStack {
                        SearchBar(value: $txtSearch, promp: "Search")
                            .focused($isFocused)
                        
                        if !txtSearch.isEmpty && !vm.searchResults.isEmpty {
                            UIMyList(manager: $vm)
                        }
                        
                        Spacer()
                    }
                    .padding(.top)
                    .zIndex(10)
                    
                    VStack {
                        Spacer()
                        VStack {
                            Button {
                                withAnimation {
                                    isSheetOn.toggle()
                                    
                                    if isSheetOn {
                                        hideKeyboard()
                                    }
                                }
                                
                            } label: {
                                HStack() {
                                    Text(vm.currentMKItemSelected?.name ?? "My Wishes")
                                        .fontWeight(.semibold)
                                        .fontDesign(.rounded)
                                    Spacer()
                                    
                                    Image(systemName:  "chevron.up")
                                        .scaleEffect(isSheetOn ? -1 : 1)
                                        .foregroundStyle(.lightGrayVercel)
                                }
                                .frame(height: 50)
                                .foregroundStyle(.white)
                                .padding(.horizontal)
                            }
                            Divider()
                            
                            if vm.myWishes.isEmpty {
                                VStack {
                                    Spacer()
                                    Text("You don't have any wish yet!")
                                        .font(.footnote)
                                        .foregroundStyle(.lightGrayVercel)
                                    Spacer()
                                }
                                .frame(height: 250)

                            } else {
                                ScrollView {
                                    VStack {
                                        ForEach(vm.myWishes) {wish in
                                            WishCellForAddPlace(manager: $vm, item: wish)
                                            
                                        }
                                    }
                                }
                                .frame(height: 250)
                            }
                            
                        }
                        .frame(width: .infinity, height: 320)
                        .background {
                            UnevenRoundedRectangle(cornerRadii: myRadiiSheet)
                                .foregroundStyle(.regularMaterial)
                        }
                        .offset(y: isSheetOn ? 0 : 270)
                        
                    }
                    .zIndex(10)
                    
                    Map(position: $vm.cameraPosition) {
                        UserAnnotation()
                        if let place = vm.currentMKItemSelected {
                            Marker(item: place)
                        }
                        
                        ForEach(vm.myWishes.filter {$0.place != nil}) { wish in
                            if let place = wish.place?.convertedToCLLocationCoordinate2D() {
                                Marker(wish.name, coordinate: place)
                            }
                        }
                    }
                    .mapStyle(.hybrid(elevation: .realistic))
                }
                
            }
            .onChange(of: txtSearch, { _, newValue in
                withAnimation {
                    vm.searchPlaceByName(newValue)
                }
            })
            .onChange(of: isFocused, { oldValue, newValue in
                if newValue {
                    withAnimation() {
                        isSheetOn = false
                    }
                }
            })
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Explorer")
                        .fontDesign(.rounded)
                        .fontWeight(.semibold)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.black, for: .navigationBar)
            .onAppear {
                vm.requestUseGps()
                vm = .init()
            }
        }
        
    }
}

#Preview {
    TabView {
        Tab("My Tab", systemImage: "location.square") {
            ExploreView()
        }
        
    }
}
