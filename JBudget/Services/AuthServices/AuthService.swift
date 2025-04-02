//
//  AuthService.swift
//  JBudget
//
//  Created by Jeanpiere Laura on 14/03/25.
//

import Foundation
@preconcurrency import FirebaseAuth
import FirebaseFirestore

enum AuthError: String, Error {
    case createUserFailed = "Error al crear el usuario."
    case findUserFailed = "Error al encontrar el usuario"
    case convertDataFailed = "Error al convertir los datos."
}

protocol AuthServiceProtocol: Sendable {
    func createNewUser(email: String, password: String, username: String) async throws
    func getCurrentUser() async throws -> JUser?
}

final class AuthService: AuthServiceProtocol {
    
    private let delegate = Auth.auth()
    private let userCollection = Firestore.firestore().collection("users")
    
    func createNewUser(email: String, password: String, username: String) async throws {
        
        do {
            let valueUser = try await delegate.createUser(withEmail: email, password: password)
            
            let userRef = userCollection.document(valueUser.user.uid)
            
            let newUser = JUser(userName: username,
                                email: valueUser.user.email ?? "No Email",
                                isPremium: false)
            
            try userRef.setData(from: newUser)
            
        } catch {
            throw AuthError.createUserFailed
        }
    }
    
    func getCurrentUser() async throws -> JUser? {
        
        do {
            guard let uuidAuth = delegate.currentUser?.uid else {
                return nil
            }
            
            let data = try await userCollection.document(uuidAuth).getDocument(as: JUser.self)
            return data

        } catch  {
            throw AuthError.convertDataFailed
        }
    }
    
}
