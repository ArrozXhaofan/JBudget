//
//  AuthViewModel.swift
//  JBudget
//
//  Created by Jeanpiere Laura on 2/04/25.
//

import Foundation

@MainActor
final class AuthViewModel: ObservableObject {
    
    @Published var haveAccess: Bool = false
    @Published var jUser: JUser?
    
    @Published var isLoading: Bool = false
    
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
                
            } catch let myError as AuthError {
                print(myError.rawValue)
            } catch {
                print(error.localizedDescription)
            }
            getCurrentUser()
            
            isLoading = false
        }
    }
    
    func getCurrentUser() {
        Task(priority: .userInitiated) {
            do {
                jUser = try await manager.getCurrentUser()
                haveAccess.toggle()
            } catch let myError as AuthError {
                print(myError.rawValue)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
