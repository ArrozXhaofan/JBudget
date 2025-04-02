//
//  JBudgetApp.swift
//  JBudget
//
//  Created by Jeanpiere Laura on 14/03/25.
//

import SwiftUI
import FirebaseCore

@main
struct JBudgetApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var authDelegate = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            if authDelegate.jUser == nil {
                AuthView(manager: authDelegate)
            } else {
                MainView()
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
