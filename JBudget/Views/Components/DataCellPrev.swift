//
//  DataCellPrev.swift
//  JBudget
//
//  Created by Jean Laura on 2/02/25.
//

import SwiftUI

enum TypeData {
    case budget
    case income
    case expense
    case wishItem
}

struct DataCellModel{
    let id: UUID
    let name: String
    let value: Double
    let type: TypeData
}

struct DataCellPrev: View {
    
    @Binding var manager: HomeViewModel
    
    var data: DataCellModel
    
    @State private var txtName: String = ""
    @State private var txtAmount: String = ""
    @State private var isToggle = false
    
    private var heightRow: CGFloat {
        switch data.type {
        case .budget:
            return 180
        case .income, .expense,.wishItem:
            return 180
        }
    }
    
    private var typeText: String {
        switch data.type {
        case .budget:
            "Budget"
        case .income:
            "Income"
        case .expense:
            "Expense"
        case .wishItem:
            "Wish"
        }
    }
    
    private var imageText: String {
        switch data.type {
        case .budget:
            "wallet.bifold.fill"
        case .income:
            "creditcard.fill"
        case .expense:
            "cart.fill"
        case .wishItem:
            "bag.fill"
        }
    }
    
    private var valueColor: Color {
        switch data.type {
        case .budget:
            return data.value > 0 ? .blue : .orange
        case .income:
            return .green
        case .expense:
            return .red
        case .wishItem:
            return .mint
        }
    }
    
    var body: some View {
        
        VStack {
            Button {
                withAnimation {
                    isToggle.toggle()
                }
            } label: {
                HStack {
                    VStack {
                        HStack {
                            Image(systemName: imageText)
                                .foregroundStyle(.white)
                            VStack(alignment: .leading) {
                                Text(data.name)
                                    .font(.footnote)
                                    .foregroundStyle(.white)
                                Text(typeText)
                                    .font(.caption)
                                    .foregroundStyle(Color.lightGrayVercel)
                            }
                            Spacer()
                        }
                    }
                    
                    HStack(alignment: .center, spacing: 15) {
                        
                        Image(systemName: "peruviansolessign")
                            .font(.system(size: 12))
                            .foregroundStyle(.lightGrayVercel)
                        
                        Text(data.value.description)
                            .font(.callout)
                            .fontWeight(.light)
                            .fontDesign(.monospaced)
                            .foregroundStyle(valueColor)
                    }
                    
                    Image(systemName: "chevron.down")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(Color.lightGrayVercel)
                        .scaleEffect(y: isToggle ? -1 : 1)
                    
                }
                .padding(.top, isToggle ? 10 : 0)
            }
            
            if isToggle {
                
                VStack {
                    Text("Edit \(typeText.lowercased())")
                        .font(.footnote)
                        .foregroundStyle(.white)
                    
                    HStack {
                        TextField("",   text: $txtName,
                                  prompt: Text("Nombre")
                            .foregroundStyle(.lightGrayVercel))
                        .frame(width: 300)
                        .font(.subheadline)
                    }
                    .frame(width: 320, height: 40)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(Color.blackGrayVercel)
                            .background {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.borderGray , lineWidth: 2)
                            }
                    }
                    
                    if data.type != .budget {
                        HStack {
                            TextField("",   text: $txtAmount,
                                      prompt: Text("Amount ")
                                .foregroundStyle(.lightGrayVercel))
                            .keyboardType(.numberPad)
                            .frame(width: 300)
                            .font(.subheadline)
                        }
                        .frame(width: 320, height: 40)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(Color.blackGrayVercel)
                                .background {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.borderGray , lineWidth: 2)
                                }
                        }
                    } else {
                        
                        HStack(spacing: 10) {
                            NavigationLink(value: manager.getBudgetById(data.id)) {
                                HStack {
                                    Text("View Details")
                                        .font(.subheadline)
                                        .foregroundStyle(.white)
                                }
                                .frame(width: 120, height: 40)
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
                        .frame(width: 320, height: 40)
                        .padding(.top, 5)
                    }
                    
                }
                .padding(.vertical, 5)
                .onChange(of: txtName) { _, newValue in
                    switch data.type {
                    case .budget:
                        manager.editBudget(identifier: data.id, name: newValue)
                    case .income:
                        manager.editIncome(identifier: data.id, name: newValue, value: txtAmount)
                    case .expense:
                        manager.editExpense(identifier: data.id, name: newValue, value: txtAmount)
                    case .wishItem:
                        manager.editWishFromPrevCell(identifier: data.id,
                                                     name: newValue,
                                                     amount: txtAmount)
                    }
                }
                .onChange(of: txtAmount) { _, newValue in
                    switch data.type {
                    case .budget: break
                    case .income:
                        manager.editIncome(identifier: data.id, name: txtName, value: newValue)
                    case .expense:
                        manager.editExpense(identifier: data.id, name: txtName, value: newValue)
                    case .wishItem:
                        manager.editWishFromPrevCell(identifier: data.id,
                                                     name: txtName ,
                                                     amount: newValue)
                    }
                }
                Spacer()
            }
        }
        .padding(.horizontal)
        .frame(width: 350, height: isToggle ? heightRow : 70)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(Color.blackGrayVercel)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.borderGray , lineWidth: 2)
                }
        }
        .onAppear {
            txtName = data.name
            txtAmount = data.value.description
        }
    }
}

#Preview {
    DataCellPrev(manager: .constant(HomeViewModel()),
                 data: DataCellModel(id: UUID(),
                                     name: "July Budget",
                                     value: 1400,
                                     type: .wishItem))
}
