//
//  AddWishe.swift
//  JBudget
//
//  Created by Jean Laura on 27/02/25.
//

import SwiftUI

/*
 var name: String
 var descriptionWish: String?
 var amount: Double
 var minAmount: Double?
 var maxAmount: Double?
 var place: geoCoordinate?*/

struct AddWish: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var vm: HomeViewModel
    
    @State private var txtName: String = ""
    @State private var txtDescription: String = ""
    @State private var txtAmount: String = ""
    @State private var txtMinAmount: String = ""
    @State private var txtMaxAmount: String = ""
    
    
    var body: some View {
        
        VStack {
            UIMyTextField(value: $txtName, prompt: "Name")
            UIMyTextField(value: $txtAmount, prompt: "Amount", keyboardType: .numberPad)
            
            Text("Optional values")
                .font(.footnote)
                .foregroundStyle(.white)
                .frame(width: 350, alignment: .leading)
                .padding(.top)
            
            UIMyTextField(value: $txtDescription, prompt: "Description")
            
            HStack {
                UIMyTextField(value: $txtMinAmount,
                              prompt: "Min Amount",
                              width: 170,
                              keyboardType: .numberPad)
                
                UIMyTextField(value: $txtMaxAmount,
                              prompt: "Max Amount",
                              width: 170,
                              keyboardType: .numberPad)
            }
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
                        Text("New Wish")
                            .font(.footnote)
                            .foregroundStyle(.white)
                    }
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    vm.addWish(name: txtName,
                               description: txtDescription,
                               amount: txtAmount,
                               minAmount: txtMinAmount,
                               maxAmount: txtMaxAmount)
                    
                    dismiss()
                    hideKeyboard()
                    
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
        AddWish(vm: .constant(HomeViewModel()))
    }
}
