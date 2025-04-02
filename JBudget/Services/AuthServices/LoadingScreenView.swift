//
//  LoadingScreenView.swift
//  JBudget
//
//  Created by Jeanpiere Laura on 2/04/25.
//

import SwiftUI

struct LoadingScreenView: View {
    
    @ObservedObject var manager: AuthViewModel
    
    var body: some View {
        VStack {
            VStack {
                Image(systemName: "leaf.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(.green)
                    .shadow(color: .green, radius: 7)
                
                Text("JBudget")
                    .font(.custom("Figtree", size: 22))
            }
            .frame(width: 120, height: 120)
            .background {
                RoundedRectangle(cornerRadius: 25)
                    .stroke(.white, lineWidth: 0.5)
            }
            
            ProgressView()
                .padding(.vertical)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ultraThinMaterial)
        .opacity(manager.chargingScreen ? 1 : 0)
        .animation(.easeInOut(duration: 0.3), value: manager.chargingScreen)
    }
}

#Preview {
    LoadingScreenView(manager: AuthViewModel())
}
