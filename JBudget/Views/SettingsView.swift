//
//  SettingsView.swift
//  JBudget
//
//  Created by Jeanpiere Laura on 22/03/25.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Image(systemName: "gear")
                        Text("Configuracion")
                            .font(.custom("Figtree", size: 22))
                    }

                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
