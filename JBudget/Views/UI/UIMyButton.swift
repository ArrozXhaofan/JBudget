//
//  UIMyButton.swift
//  JBudget
//
//  Created by Jean Laura on 27/02/25.
//

import SwiftUI

struct UIMyButton: View {
    
    var promp: String
    var action: () -> Void
    
    var body: some View {
        
        Button(action: action) {
            VStack{
                Text(promp)
                    .foregroundStyle(.black)
                    .fontWeight(.medium)
            }
            .frame(width: 100, height: 40)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    UIMyButton(promp: "Holo") {
        print("hola")
    }
}
