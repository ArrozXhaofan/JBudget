//
//  UIMyTextField 2.swift
//  JBudget
//
//  Created by Jeanpiere Laura on 2/04/25.
//


import SwiftUI

struct UIMyPassField: View {
    
    @State private var onShow = false
    
    @Binding var value: String
    var prompt: String?
    var width: CGFloat = 350
    var keyboardType: UIKeyboardType = .default
    
    private var widthTextField: CGFloat {
        width - 48
    }
    
    var body: some View {
        HStack(spacing: 8) {
            HStack {
                if onShow {
                    TextField("",   text: $value,
                              prompt: Text(prompt ?? "")
                        .foregroundStyle(.lightGrayVercel))
                    .font(.subheadline)
                    .keyboardType(keyboardType)
                    .padding(.horizontal)
                } else {
                    SecureField("",   text: $value,
                                prompt: Text(prompt ?? "")
                        .foregroundStyle(.lightGrayVercel))
                    .font(.subheadline)
                    .keyboardType(keyboardType)
                    .padding(.horizontal)
                }
            }
            .frame(width: widthTextField, height: 40)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(Color.blackGrayVercel)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.borderGray , lineWidth: 2)
                    }
            }
            
            Button {
                withAnimation(.bouncy) {
                    onShow.toggle()
                }
            } label: {
                VStack {
                    Image(systemName: onShow ? "eye.slash" : "eye.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 19, height: 19)
                        .foregroundStyle(.white)
                }
                .frame(width: 40, height: 40)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(Color.blackGrayVercel)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.borderGray , lineWidth: 2)
                        }
                }
            }
            
            Spacer()
        }
        .frame(width: width, height: 40)
        
    }
}

#Preview {
    UIMyPassField(value: .constant(""), prompt: "My Field", width: 350)
}
