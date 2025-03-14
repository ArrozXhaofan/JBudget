//
//  SheetAddItems.swift
//  JBudget
//
//  Created by Jean Laura on 3/02/25.
//

import SwiftUI

struct SheetAddItems: View {
    
    @Binding var vm: HomeViewModel
    @Binding var sheetControler: Bool
    
    var body: some View {
        
        NavigationStack {
            VStack(alignment: .leading) {
                
                NavigationLink {
                    AddBudget(vm: $vm, sheetControler: $sheetControler)
                } label: {
                    HStack {
                        VStack {
                            Image(systemName: "wallet.bifold.fill")
                                .font(.system(size: 14))
                        }
                        .frame(width: 20)
                        Text("Budget")
                    }
                    .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                }
                
                NavigationLink {
                    AddIncExp(vm: $vm, typeCase: .income)
                } label: {
                    HStack {
                        VStack {
                            Image(systemName: "creditcard.fill")
                                .font(.system(size: 14))
                        }
                        .frame(width: 20)
                        
                        Text("Income")
                    }
                    .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                }
                
                NavigationLink {
                    AddIncExp(vm: $vm, typeCase: .expense)
                } label: {
                    HStack {
                        VStack {
                            Image(systemName: "cart.fill")
                                .font(.system(size: 14))
                        }
                        .frame(width: 20)
                        Text("Expense")
                    }
                    .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                }
                
                NavigationLink {
                    AddWish(vm: $vm)
                } label: {
                    HStack {
                        VStack {
                            Image(systemName: "bag.fill")
                                .font(.system(size: 14))
                        }
                        .frame(width: 20)
                        Text("Wishes")
                    }
                    .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                }
                Spacer()
            }
            .foregroundStyle(.white)
            .fontWeight(.light)
            .fontDesign(.rounded)
            .padding()
            .background(Color.blackGrayVercel)
        }
    }
}

#Preview {
    SheetAddItems(vm: .constant(HomeViewModel()), sheetControler: .constant(false))
}
