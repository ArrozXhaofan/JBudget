//
//  AddBudget.swift
//  JBudget
//
//  Created by Jean Laura on 3/02/25.
//

import SwiftUI

struct AddBudget: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var vm: HomeViewModel
    @Binding var sheetControler: Bool
    
    @State private var txtName: String = ""
    
    var body: some View {
        VStack {
            
            HStack {
                TextField("",   text: $txtName,
                          prompt: Text("Nombre")
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
            .padding(.top, 8)
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 12)
                            .foregroundStyle(Color.lightGrayVercel)
                        Text("Add Budget")
                            .font(.footnote)
                            .foregroundStyle(.white)
                    }
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    
                    let item = Budget(name: txtName, incomes: [], expenses: [])
                    vm.addBudget(data: item)
                    
                    dismiss()
                    hideKeyboard()
                    
                    sheetControler = false
                    vm.newBudgedForNavigation = item
                    
                } label: {
                    Text("Done")
                        .font(.footnote)
                        .foregroundStyle(.white)
                        .bold()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity)
        .background(Color.blackGrayVercel)

    }
}

#Preview {
    NavigationStack {
        AddBudget(vm: .constant(HomeViewModel()),
                  sheetControler: .constant(true))
    }
}
