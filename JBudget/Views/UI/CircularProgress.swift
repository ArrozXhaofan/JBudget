//
//  CircularProgress.swift
//  JBudget
//
//  Created by Jean Laura on 4/02/25.
//

import SwiftUI

struct CircularProgress: View {
    
    var progress: Double
    var height: CGFloat?
    var type: TypeData
    
    private var colorCircle: Color {
        switch type {
        case .income, .budget:
            progress > 0.5 ? .green : .blue
        case .expense:
            progress > 0.5 ? .red : .blue
        case .wishItem:
            progress > 0.7 ? .orange : .pink
        }
    }
    
    var body: some View {
        ZStack {
            // Círculo de fondo oscuro
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 5)
                .frame(width: height ?? 20, height: height ?? 20)
            
            // Barra de progreso circular
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(colorCircle, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                .rotationEffect(.degrees(-90))  // Para empezar desde arriba
                .frame(width: height ?? 20, height: height ?? 20)
        }
    }
}

#Preview {
    CircularProgress(progress: 0.4, height: 17, type: .wishItem)
}
