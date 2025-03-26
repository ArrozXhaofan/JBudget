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
            
            Tab("Plans", systemImage: "leaf") {
                PlansView()
            }
            
            Tab("MapWish", systemImage: "globe.americas.fill") {
                ExploreView()
            }
            
            Tab("Settings", systemImage: "gear") {
                SettingsView()
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
