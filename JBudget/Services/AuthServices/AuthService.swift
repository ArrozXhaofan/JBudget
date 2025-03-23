//
//  AuthService.swift
//  JBudget
//
//  Created by Jeanpiere Laura on 14/03/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class AuthService {
    
    let delegate = Auth.auth()
    let userCollection = Firestore.firestore().collection("users")
    
    func createNewUser(email: String, password: String) async throws {
        
        do {
            let valueUser = try await delegate.createUser(withEmail: email, password: password)
            
            let userRef = userCollection.document(valueUser.user.uid)
            
            let newUser = JUser(userName: "NewUser",
                                email: valueUser.user.email ?? "No Email",
                                isVip: false)
            
            try userRef.setData(from: newUser)
            
        } catch {
            throw error
        }
        
        
            
        
    }
    
}
