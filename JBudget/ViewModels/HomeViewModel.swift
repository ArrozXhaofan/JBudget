//
//  HomeViewModel.swift
//  JBudget
//
//  Created by Jean Laura on 3/02/25.
//

import Foundation
import Observation

@Observable final class HomeViewModel {
    
    //PUBLIC DATA
    var allBudgets: [Budget] = []
    var allIncomes: [Income] = []
    var allExpenses: [Expense] = []
    var allWishes: [Wish] = []
    
    
    var newBudgedForNavigation: Budget?
    var errorString: String?
    
    //USE CASE
    private var createBudgetUseCase: CreateBudgetUseCaseProtocol
    private var updateBudgetUseCase: UpdateBudgetsUseCaseProtocol
    private var deleteBudgetUseCase: DeleteBudgetsUseCaseProtocol
    private var getBudgetsUseCase: GetAllBudgetsUseCaseProtocol
    private var createIncomeUseCase: CreateIncomesUseCaseProtocol
    private var updateIncomeUseCase: UpdateIncomesUseCaseProtocol
    private var deleteIncomeUseCase: DeleteIncomesUseCaseProtocol
    private var getIncomesUseCase: GetAllIncomesUseCaseProtocol
    private var createExpenseUseCase: CreateExpenseUseCaseProtocol
    private var updateExpenseUseCase: UpdateExpenseUseCaseProtocol
    private var deleteExpenseUseCase: DeleteExpenseUseCaseProtocol
    private var getExpensesUseCase: GetAllExpensesUseCaseProtocol
    private var createWishUseCase: CreateWishUseCaseProtocol
    private var updateWishUseCase: UpdateWishUseCaseProtocol
    private var deleteWishUseCase: DeleteWishUseCaseProtocol
    private var getWishesUseCase: GetAllWishUseCaseProtocol
    
    @MainActor
    init(/*getIncomesUseCase: GetAllIncomesUseCaseProtocol = GetAllIncomesUseCase(),
         createExpenseUseCase: CreateExpenseUseCaseProtocol = CreateExpenseUseCase(),
         updateExpenseUseCase: UpdateExpenseUseCaseProtocol = UpdateExpenseUseCase(),
         deleteExpenseUseCase: DeleteExpenseUseCaseProtocol = DeleteExpenseUseCase(),
         getExpensesUseCase: GetAllExpensesUseCaseProtocol =  GetAllExpensesUseCase(),
         createWishUseCase: CreateWishUseCaseProtocol = CreateWishUseCase(),
         updateWishUseCase: UpdateWishUseCaseProtocol = UpdateWishUseCase(),
         deleteWishUseCase: DeleteWishUseCaseProtocol = DeleteWishUseCase(),
         getWishesUseCase: GetAllWishUseCaseProtocol = GetAllWishUseCase()*/
    ) {
        self.createBudgetUseCase =  CreateBudgetUseCase()
        self.updateBudgetUseCase =  UpdateBudgetsUseCase()
        self.deleteBudgetUseCase =  DeleteBudgetsUseCase()
        self.getBudgetsUseCase =  GetAllBudgetsUseCase()
        self.createIncomeUseCase =  CreateIncomesUseCase()
        self.updateIncomeUseCase =  UpdateIncomesUseCase()
        self.deleteIncomeUseCase =  DeleteIncomesUseCase()
        self.getIncomesUseCase =  GetAllIncomesUseCase()
        self.createExpenseUseCase =  CreateExpenseUseCase()
        self.updateExpenseUseCase =  UpdateExpenseUseCase()
        self.deleteExpenseUseCase =  DeleteExpenseUseCase()
        self.getExpensesUseCase =  GetAllExpensesUseCase()
        self.createWishUseCase =  CreateWishUseCase()
        self.updateWishUseCase =  UpdateWishUseCase()
        self.deleteWishUseCase =  DeleteWishUseCase()
        self.getWishesUseCase =  GetAllWishUseCase()
        
        getAllBudgets()
        getAllIncomes()
        getAllExpenses()
        getAllWishes()
    }
    
    //Budget Functions
    
    @MainActor func getAllBudgets() {
        do {
            allBudgets = try getBudgetsUseCase.getAllData()
        } catch let dataError as DataBaseError {
            errorString = dataError.rawValue
        } catch {
            errorString = "Ocurrio un error inesperado: \(error.localizedDescription)"
        }
    }
    
    @MainActor func getBudgetById(_ identifier: UUID) -> Budget? {
        do {
            return try getBudgetsUseCase.getBudgetById(identifier)
            
        } catch let databaseError as DataBaseError {
            errorString = databaseError.rawValue
            return nil
        } catch {
            errorString = "Ocurrio un error inesperado: \(error.localizedDescription)"
            return nil
        }
    }
    
    @MainActor func addBudget(data: Budget) {
        do {
            try createBudgetUseCase.newBudget(value: data)
            getAllBudgets()
            
        } catch let databaseError as DataBaseError {
            errorString = databaseError.rawValue
        } catch {
            errorString = "Ocurrio un error inesperado: \(error.localizedDescription)"
        }
    }
    
    @MainActor func editBudget(identifier: UUID, name: String) {
        do {
            try updateBudgetUseCase.update(identifier: identifier, newTitle: name)
            getAllBudgets()
        } catch let databaseError as DataBaseError {
            errorString = databaseError.rawValue
        } catch {
            errorString = "Ocurrio un error inesperado: \(error.localizedDescription)"
        }
    }
    
    @MainActor func deleteBudget(_ value: UUID) {
        do {
            try deleteBudgetUseCase.delete(value)
            getAllBudgets()
        } catch let databaseError as DataBaseError {
            errorString = databaseError.rawValue
        } catch {
            errorString = "Ocurrio un error inesperado: \(error.localizedDescription)"
        }
    }
    
    //Incomes functions
    
    @MainActor func getAllIncomes() {
        do {
            allIncomes = try getIncomesUseCase.getAllIncomes()
            
        } catch let dataError as DataBaseError {
            errorString = dataError.rawValue
        } catch {
            errorString = "Ocurrio un error inesperado: \(error.localizedDescription)"
        }
    }
    
    @MainActor func addIncome(name: String, value: String) {
        guard let amount = value.stringToDouble() else {
            errorString = "Please enter a valid value"
            return
        }
        let data = Income(name: name, amount: amount)
        do {
            try createIncomeUseCase.insert(data)
            getAllIncomes()
            
        } catch let dataError as DataBaseError {
            errorString = dataError.rawValue
        } catch {
            errorString = "Ocurrio un error inesperado: \(error.localizedDescription)"
        }
    }
    
    @MainActor func editIncome(identifier: UUID, name: String, value: String) {
        guard let amount = value.stringToDouble() else {
            print("Error in type casting")
            return
        }
        do {
            try updateIncomeUseCase.update(identifier: identifier, name: name, value: amount)
            getAllBudgets()
            
        } catch let dataError as DataBaseError {
            errorString = dataError.rawValue
        } catch {
            errorString = "Ocurrio un error inesperado: \(error.localizedDescription)"
        }
    }
    
    @MainActor func deleteIncome(_ value: UUID) {
        do {
            try deleteIncomeUseCase.delete(value)
            getAllIncomes()
        } catch let dataError as DataBaseError {
            errorString = dataError.rawValue
        } catch {
            errorString = "Ocurrio un error inesperado: \(error.localizedDescription)"
        }
    }
    
    //Expenses functions
    
    @MainActor func getAllExpenses() {
        do {
            allExpenses = try getExpensesUseCase.getAllData()
        } catch let dataError as DataBaseError {
            errorString = dataError.rawValue
        } catch {
            errorString = "Ocurrio un error inesperado: \(error.localizedDescription)"
        }
    }
    
    @MainActor func addExpense(name: String, value: String) {
        guard let amount = value.stringToDouble() else {
            errorString = "Please enter a valid value"
            return
        }
        let data = Expense(name: name, amount: amount)
        do {
            try createExpenseUseCase.insert(data)
            getAllExpenses()
        } catch let dataError as DataBaseError {
            errorString = dataError.rawValue
        } catch {
            errorString = "Ocurrio un error inesperado: \(error.localizedDescription)"
        }
    }
    
    @MainActor func editExpense(identifier: UUID, name: String, value: String) {
        
        guard let amount = value.stringToDouble() else {
            print("Error in type casting")
            return
        }
        do {
            try updateExpenseUseCase.update(identifier: identifier, name: name, value: amount)
            getAllBudgets()
        } catch let dataError as DataBaseError {
            errorString = dataError.rawValue
        } catch {
            errorString = "Ocurrio un error inesperado: \(error.localizedDescription)"
        }
    }
    
    @MainActor func deleteExpense(_ value: UUID) {
        do {
            try deleteExpenseUseCase.delete(identifier: value)
            getAllExpenses()
        } catch let dataError as DataBaseError {
            errorString = dataError.rawValue
        } catch {
            errorString = "Ocurrio un error inesperado: \(error.localizedDescription)"
        }
    }
    
    //Wishes functions
    
    @MainActor func getAllWishes() {
        do {
            allWishes = try getWishesUseCase.getAllData()
        } catch let dataError as DataBaseError {
            errorString = dataError.rawValue
        } catch {
            errorString = "Ocurrio un error inesperado: \(error.localizedDescription)"
        }
    }
    
    @MainActor func addWish(name: String, description: String, amount: String, minAmount: String, maxAmount: String) {
        
        guard let realAmount = amount.stringToDouble() else {
            print("Error in type casting")
            return
        }
        
        let newWish = Wish(name: name,
                           descriptionWish: description,
                           amount: realAmount,
                           minAmount: minAmount.stringToDouble(),
                           maxAmount: maxAmount.stringToDouble(),
                           place: nil)
        
        do {
            try createWishUseCase.insert(value: newWish)
            getAllWishes()
            
        } catch let dataError as DataBaseError {
            errorString = dataError.rawValue
        } catch {
            errorString = "Ocurrio un error inesperado: \(error.localizedDescription)"
        }
    }
    
    @MainActor func editWish(identifier: UUID, name: String, description: String, amount: String, minAmount: String, maxAmount: String) {
        
        guard let realAmount = amount.stringToDouble() else {
            print("Error in type casting")
            return
        }
        
        let newValue = Wish(name: name,
                            descriptionWish: description,
                            amount: realAmount,
                            minAmount: minAmount.stringToDouble(),
                            maxAmount: maxAmount.stringToDouble(),
                            place: nil)
        
        do {
            try updateWishUseCase.update(identifier: identifier, value: newValue)
            getAllWishes()
            
        } catch let dataError as DataBaseError {
            errorString = dataError.rawValue
        } catch {
            errorString = "Ocurrio un error inesperado: \(error.localizedDescription)"
        }
    }
    
    @MainActor func editWishFromPrevCell(identifier: UUID, name: String, amount: String) {
        
        guard let realAmount = amount.stringToDouble() else {
            print("Error in type casting")
            return
        }
        
        do {
            try updateWishUseCase.updateWishObligatoryValues(identifier: identifier, name: name, amount: realAmount)
            getAllWishes()
            
        } catch let dataError as DataBaseError {
            errorString = dataError.rawValue
        } catch {
            errorString = "Ocurrio un error inesperado: \(error.localizedDescription)"
        }
    }
    
    @MainActor func deleteWish(identifier: UUID) {
        
        do {
            try deleteWishUseCase.delete(identifier: identifier)
            getAllWishes()
            
        } catch let dataError as DataBaseError {
            errorString = dataError.rawValue
        } catch {
            errorString = "Ocurrio un error inesperado: \(error.localizedDescription)"
        }
    }

}

