//
//  AddInc&Exp.swift
//  JBudget
//
//  Created by Jean Laura on 3/02/25.
//

import SwiftUI

enum TpyCaseUse {
    case income
    case expense
}

struct AddIncExp: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var vm: HomeViewModel
    
    var typeCase: TpyCaseUse
    
    @State private var txtName: String = ""
    @State private var txtAmount: String = ""
    
    
    var body: some View {
        VStack(spacing: 15) {
            
            UIMyTextField(value: $txtName, prompt: "Nombre")
            UIMyTextField(value: $txtAmount, prompt: "Amount", keyboardType: .numberPad)
            UIMyButton(promp: "Add") {
                if typeCase == .expense {
                    vm.addExpense(name: txtName, value: txtAmount)
                    
                } else if typeCase == .income {
                    vm.addIncome(name: txtName, value: txtAmount)
                }
                
                txtName = ""
                txtAmount = ""
                
                hideKeyboard()
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
                        Text(typeCase == TpyCaseUse.expense ? "Add Expense" : "Add Income")
                            .font(.footnote)
                            .foregroundStyle(.white)
                    }
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
        AddIncExp(vm: .constant(HomeViewModel()), typeCase: .expense)
            .modelContainer(for: [Budget.self, Income.self, Expense.self],
                                            inMemory: true)
    }
    
}



