//
//  ContentView.swift
//  JBudget
//
//  Created by Jean Laura on 2/02/25.
//

import SwiftUI
import SwiftData

struct MainView: View {
    
    var body: some View {
        
        TabView {
            Tab("Principal", systemImage: "homekit") {
                HomeView()
            }
            
            Tab("MapWish", systemImage: "globe.americas.fill") {
                ExploreView()
            }
            
            Tab("Home", systemImage: "percent") {
                ContentUnavailableView("Hola", systemImage: "eye.slash")
            }
            
            Tab("Settings", systemImage: "gear") {
                ContentUnavailableView("Hola", systemImage: "eye.slash")
            }
        }
        .tint(.white)
    }
    
}


#Preview {
    MainView()
        .modelContainer(for: [Budget.self, Income.self, Expense.self],
                        inMemory: true)
}
