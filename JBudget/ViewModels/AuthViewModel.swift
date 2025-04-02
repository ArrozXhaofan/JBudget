//
//  AuthViewModel.swift
//  JBudget
//
//  Created by Jeanpiere Laura on 2/04/25.
//

import Foundation

@MainActor
final class AuthViewModel: ObservableObject {
    
    @Published var verificant: Bool = false
    @Published var jUser: JUser?
    
    @Published var isLoading: Bool = false
    @Published var chargingScreen: Bool = true
    
    private let manager: AuthServiceProtocol
    
    init(manager: AuthServiceProtocol = AuthService()) {
        self.manager = manager
        
        getCurrentUser()
    }
    
    func createUser(email: String, password: String, confirmPassword: String , username: String)  {
        
        Task {
            isLoading = true
            
            if password != confirmPassword {
                isLoading = false
                print("Las contraseñas no coinciden")
                return
            }
            
            do {
                try await manager.createNewUser(email: email, password: password, username: username)
                getCurrentUser()
                
            } catch let myError as AuthError {
                print(myError.rawValue)
            } catch {
                print(error.localizedDescription)
            }
            
            isLoading = false
        }
    }
    
    func getCurrentUser() {
        Task {
            do {
                chargingScreen = true
                jUser = try await manager.getCurrentUser()
                chargingScreen = false
            } catch let myError as AuthError {
                print(myError.rawValue)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
