//
//  ExtractedView.swift
//  JBudget
//
//  Created by Jean Laura on 2/02/25.
//
import SwiftUI

struct SearchBar: View {
    
    @Binding var value: String
    
    var promp = "Search"
    
    var body: some View {
        HStack {
            
            VStack(alignment: .center) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.lightGrayVercel)
            }
            .frame(width: 20)
            
            TextField("",   text: $value,
                      prompt: Text(promp)
                .foregroundStyle(.lightGrayVercel))
            .frame(width: 300)
            .font(.subheadline)
            
        }
        .frame(width: 350, height: 40)
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
    VStack {
        SearchBar(value: .constant(""))
            .padding(.vertical)
        Spacer()
    }
}
