//
//  UIMyTextField.swift
//  JBudget
//
//  Created by Jean Laura on 27/02/25.
//

import SwiftUI

struct UIMyTextField: View {
    
    @Binding var value: String
    var prompt: String?
    var width: CGFloat = 350
    var keyboardType: UIKeyboardType = .default
    
    private var widthTextField: CGFloat {
        width - 50
    }
    
    var body: some View {
        HStack {
            
            TextField("",   text: $value,
                      prompt: Text(prompt ?? "")
                .foregroundStyle(.lightGrayVercel))
            .frame(width: widthTextField)
            .font(.subheadline)
            .keyboardType(keyboardType)
        }
        .frame(width: width, height: 40)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(Color.blackGrayVercel)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.borderGray , lineWidth: 2)
                }
        }
    }
}

#Preview {
    UIMyTextField(value: .constant(""), prompt: "My Field", width: 250)
}
