//
//  BudgetView.swift
//  JBudget
//
//  Created by Jean Laura on 4/02/25.
//

import SwiftUI

struct BudgetView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var manager: HomeViewModel
    
    var item: Budget
    
    @State private var totalIncomes: Double = 0
    @State private var totalExpenses: Double = 0
    
    private let barWidth: CGFloat = 350
    
    private let fisrtCardii: RectangleCornerRadii = .init(topLeading: 4, bottomLeading: 4)
    
    var body: some View {
        VStack {
            VStack {
                VStack {
                    HStack(spacing: 1) {
                        if item.resume > 0 {
                            if let monto = item.expenses.first?.amount  {
                                UnevenRoundedRectangle(cornerRadii: fisrtCardii)
                                    .frame(width: (monto / totalIncomes) * barWidth)
                                    .foregroundStyle(Color.randomPreset)
                                
                                if item.incomes.count > 1 {
                                    ForEach(Array(item.expenses.dropFirst()), id: \.self) { obj in
                                        Rectangle()
                                            .frame(width: ( obj.amount / totalIncomes) * barWidth)
                                            .foregroundStyle(Color.randomPreset)
                                    }
                                }
                                Spacer()
                            }
                        }
                    }
                    .frame(width: barWidth, height: 30)
                    .background {
                        RoundedRectangle(cornerRadius: 4)
                            .foregroundStyle(Color.borderGray)
                    }
                    
                    Text(" \(item.resume.description) \(item.resume > 0 ? "saves" : "!")")
                        .font(.footnote)
                }
                .padding(.bottom)
                
                ScrollView {
                    VStack {
                        Text("Incomes")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack {
                            VStack {
                                HStack {
                                    Text("Detail")
                                    Spacer()
                                    Text("Amount")
                                }
                                .fontDesign(.rounded)
                                .foregroundStyle(Color.lightGrayVercel)
                                Divider()
                                
                                VStack(spacing: 15) {
                                    
                                    ForEach(item.incomes, id: \.id) { obj in
                                        HStack {
                                            HStack(spacing: 10) {
                                                CircularProgress(progress: (obj.amount / totalIncomes) * 1.1,
                                                                 height: 15,
                                                                 type: .income)
                                                Text(obj.name)
                                            }
                                            Spacer()
                                            
                                            Text(obj.amount.description)
                                                .fontDesign(.monospaced)
                                        }
                                        .font(.system(size: 16))
                                        .contextMenu {
                                            Button("Eliminar") {
                                                manager.deleteIncome(obj.identifier)
                                                refreshCells()
                                            }
                                        }
                                    }
                                    
                                    Menu {
                                        ForEach(manager.allIncomes, id: \.identifier) { obj in
                                            Button("\(obj.name)  \(obj.amount.description)") {
                                                item.incomes.append(obj)
                                                refreshCells()
                                            }
                                        }
                                    } label: {
                                        HStack {
                                            Image(systemName: "plus")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 12, height: 12)
                                                .foregroundStyle(Color.lightGrayVercel)
                                            Text("Add Income")
                                                .font(.footnote)
                                                .foregroundStyle(.white)
                                            Spacer()
                                        }
                                    }
                                }
                                .padding(.vertical, 6)
                            }
                            .padding()
                        }
                        .frame(width: 350)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(Color.blackGrayVercel)
                                .background {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.borderGray, lineWidth: 2)
                                }
                        }
                        .padding(.bottom)
                        
                        Text("Expenses")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack {
                            VStack {
                                HStack {
                                    Text("Detail")
                                    Spacer()
                                    Text("Amount")
                                }
                                .fontDesign(.rounded)
                                .foregroundStyle(Color.lightGrayVercel)
                                Divider()
                                
                                VStack(spacing: 15) {
                                    
                                    if item.expenses.count != 0 {
                                        ForEach(item.expenses, id: \.id) { obj in
                                            HStack {
                                                HStack(spacing: 10) {
                                                    CircularProgress(
                                                        progress: (obj.amount / totalIncomes) * 1.1,
                                                        height: 15,
                                                        type: .expense)
                                                    Text(obj.name)
                                                }
                                                Spacer()
                                                
                                                Text(obj.amount.description)
                                                    .fontDesign(.monospaced)
                                            }
                                            .font(.system(size: 16))
                                            .contextMenu {
                                                Button("Eliminar") {
                                                    manager.deleteExpense(obj.identifier)
                                                    refreshCells()
                                                }
                                            }
                                        }
                                    }
                                    Menu {
                                        ForEach(manager.allExpenses, id: \.identifier) { obj in
                                            Button("\(obj.name)  \(obj.amount.description)") {
                                                item.expenses.append(obj)
                                                refreshCells()
                                            }
                                        }
                                    } label: {
                                        HStack {
                                            Image(systemName: "plus")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 12, height: 12)
                                                .foregroundStyle(Color.lightGrayVercel)
                                            Text("Add Expense")
                                                .font(.footnote)
                                                .foregroundStyle(.white)
                                            Spacer()
                                        }
                                    }
                                }
                                .padding(.vertical, 6)
                            }
                            .padding()
                        }
                        .frame(width: 350)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(Color.blackGrayVercel)
                                .background {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.borderGray, lineWidth: 2)
                                }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding()
        }
        .onAppear{
            refreshCells()
        }
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
                        Text(item.name)
                            .fontDesign(.rounded)
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(Color.white)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                
                HStack {
                    Text("\(totalExpenses.description)  of  \(totalIncomes.description)  used")
                        .font(.footnote)
                        .fontDesign(.rounded)
                        .fontWeight(.semibold)
                }
                .foregroundStyle(Color.lightGrayVercel)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

extension BudgetView {
    func refreshCells() {
        totalIncomes = item.incomes.reduce(0) { $0 + $1.amount }
        totalExpenses = item.expenses.reduce(0) { $0 + $1.amount }
    }
}

#Preview {
    NavigationStack {
        BudgetView(manager: .constant(HomeViewModel()),
                   item: Budget(name: "Julio",
                                incomes: [],
                                expenses: []
                               )
        )
    }
    .modelContainer(for: [Budget.self, Income.self, Expense.self],
                    inMemory: true)
    
}
