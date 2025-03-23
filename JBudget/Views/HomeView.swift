//
//  HomeView.swift
//  JBudget
//
//  Created by Jean Laura on 2/02/25.
//

import SwiftUI

struct HomeView: View {
    
    @State var homeviemModel: HomeViewModel = .init()
    
    @State private var searchText: String = ""
    
    @State private var resultsType: TypeData = .budget
    @State private var isAddMenuOn = false
    
    @State private var budgetResults: [Budget] = []
    @State private var incomeResults: [Income]  = []
    @State private var expenseResults: [Expense]  = []
    @State private var wisheResults: [Wish]  = []
    
    var body: some View {
        NavigationStack {
            
            VStack {
                SearchBar(value: $searchText)
                    .padding(.top)
                    .padding(.bottom, 8)
                
                HStack {
                    HStack(spacing: 17) {
                        Button("Budget") { resultsType = .budget }
                            .foregroundStyle(resultsType == TypeData.budget ? .white : .lightGrayVercel)
                        Button("Income") { resultsType = .income }
                            .foregroundStyle(resultsType == TypeData.income ? .white : .lightGrayVercel)
                        Button("Expense") { resultsType = .expense }
                            .foregroundStyle(resultsType == TypeData.expense ? .white : .lightGrayVercel)
                        Button("Wish") {  resultsType = .wishItem}
                            .foregroundStyle(resultsType == TypeData.wishItem ? .white : .lightGrayVercel)
                    }
                    .padding(.leading, 3)
                    Spacer()
                    Button {
                        isAddMenuOn = true
                    } label: {
                        HStack(alignment: .center) {
                            Text("Add New")
                        }
                        .foregroundStyle(.black)
                        .frame(width: 90, height: 35)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(.white)
                        }
                    }
                }
                .font(.subheadline)
                
                ScrollView {
                    VStack(spacing: 12) {
                        
                        if resultsType == .budget {
                            ForEach(budgetResults, id: \.identifier) { budget in
                                let prevData = budget.toPrevCell()
                                NavigationLink(value: budget) {
                                    DataCellPrev(manager: $homeviemModel, data: prevData)
                                        .contextMenu {
                                            Button("Eliminar", systemImage: "trash.fill") {
                                                withAnimation {
                                                    homeviemModel.deleteBudget(budget.identifier)
                                                }
                                            }
                                        }
                                }
                            }
                        }  else if resultsType == .income {
                            ForEach(incomeResults, id: \.identifier) { income in
                                let prevData = income.toPrevCell()
                                NavigationLink(value: income) {
                                    DataCellPrev(manager: $homeviemModel ,data: prevData)
                                        .contextMenu {
                                            Button("Eliminar", systemImage: "trash.fill") {
                                                withAnimation {
                                                    homeviemModel.deleteIncome(income.identifier)
                                                }
                                            }
                                        }
                                }
                            }
                        } else if resultsType == .expense {
                            ForEach(expenseResults, id: \.identifier) { expense in
                                let prevData = expense.toPrevCell()
                                NavigationLink(value: expense) {
                                    DataCellPrev(manager: $homeviemModel ,data: prevData)
                                        .contextMenu {
                                            Button("Eliminar", systemImage: "trash.fill") {
                                                withAnimation {
                                                    homeviemModel.deleteExpense(expense.identifier)
                                                }
                                            }
                                        }
                                }
                            }
                        } else if resultsType == .wishItem {
                            ForEach(wisheResults) { wish in
                                let prevData = wish.toPrevCell()
                                NavigationLink(value: wish) {
                                    DataCellPrev(manager: $homeviemModel, data: prevData)
                                        .contextMenu {
                                            Button("Eliminar", systemImage: "trash.fill") {
                                                withAnimation {
                                                    homeviemModel.deleteWish(identifier: wish.identifier)
                                                }
                                            }
                                        }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 1)
                    
                }
                .padding(.top)
                .onChange(of: searchText) { _, newValue in
                    
                    if searchText.isEmpty {
                        refreshCells()
                    } else {
                        budgetResults = homeviemModel.allBudgets.filter{$0.name.contains(newValue) }
                        incomeResults = homeviemModel.allIncomes.filter{$0.name.contains(newValue) }
                        expenseResults = homeviemModel.allExpenses.filter{$0.name.contains(newValue) }
                        wisheResults = homeviemModel.allWishes.filter{$0.name.contains(newValue) }
                        
                    }
                }
                .onChange(of: homeviemModel.allExpenses) { _, newItems in
                    withAnimation {expenseResults = newItems}
                }
                .onChange(of: homeviemModel.allBudgets) { _, newItems in
                    withAnimation {budgetResults = newItems}
                }
                .onChange(of: homeviemModel.allIncomes) { _, newItems in
                    withAnimation {incomeResults = newItems}
                }
                .onChange(of: homeviemModel.allWishes) { _, newItems in
                    withAnimation {wisheResults = newItems}
                }
                Spacer()
            }
            .padding(.horizontal,11)
            .navigationDestination(for: Budget.self) { value in
                BudgetView(manager: $homeviemModel, item: value)
            }
            .navigationDestination(item: $homeviemModel.newBudgedForNavigation) { value in
                BudgetView(manager: $homeviemModel, item: value)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Image(systemName: "homekit")
                        Text("Principal")
                            .font(.custom("Figtree", size: 22))
                    }

                }
            }
            .sheet(isPresented: $isAddMenuOn) {
                SheetAddItems(vm: $homeviemModel, sheetControler: $isAddMenuOn)
                    .presentationDetents([.height(300)])
                    .presentationCornerRadius(8)
            }
            .onAppear {
                refreshCells()
                homeviemModel = .init()
            }
        }
    }
}

extension HomeView {
    func refreshCells() {
        budgetResults = homeviemModel.allBudgets
        incomeResults = homeviemModel.allIncomes
        expenseResults = homeviemModel.allExpenses
        wisheResults = homeviemModel.allWishes
    }
}

#Preview {
    HomeView()
        .modelContainer(for: [Budget.self, Income.self, Expense.self],
                        inMemory: true)
}


