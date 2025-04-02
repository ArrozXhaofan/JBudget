//
//  AuthView.swift
//  JBudget
//
//  Created by Jeanpiere Laura on 14/03/25.
//

import SwiftUI

struct AuthView: View {
    
    @ObservedObject var manager: AuthViewModel
    
    @State var txtUser = ""
    @State var txtEmail = ""
    @State var txtPassword = ""
    @State var txtPasswordConfirm = ""
    
    
    var body: some View {
        ZStack {
            VStack {
                
                Text("Crear una cuenta")
                    .font(.title)
                    .fontWeight(.regular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                
                Button {
                    //
                } label: {
                    Text("Ya tengo una cuenta.")
                        .underline()
                        .font(.footnote)
                        .foregroundStyle(.lightGrayVercel)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                }
                
                VStack(spacing: 10) {
                    UIMyTextField(value: $txtUser, prompt: "Username")
                    UIMyTextField(value: $txtEmail, prompt: "Email", keyboardType: .emailAddress)
                    
                    UIMyPassField(value: $txtPassword, prompt: "Contraseña", width: 330)
                    UIMyPassField(value: $txtPasswordConfirm, prompt: "Confirmar conraseña", width: 330)
                    
                    HStack(spacing: 10) {
                        Button {
                            withAnimation(.bouncy(duration: 0.6)) {
                                manager.createUser(email: txtEmail,
                                                   password: txtPassword,
                                                   confirmPassword: txtPasswordConfirm,
                                                   username: txtUser)
                            }
                        } label: {
                            VStack {
                                HStack {
                                    if !manager.isLoading  {
                                        Text("Hecho")
                                    }
                                    
                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 11, height: 11)
                                }
                                .padding(.horizontal)
                                
                            }
                            .foregroundStyle(.black)
                            .frame(height: 40)
                            .background {
                                RoundedRectangle(cornerRadius: 7)
                                    .foregroundStyle(.white)
                                    .opacity(manager.isLoading ? 0.3 : 1)
                            }
                        }
                        .disabled(manager.isLoading)
                        
                        if manager.isLoading {
                            ProgressView()
                        }
                    }
                    .padding(.top)
                }
                .padding(.top, 40)
                
                Spacer()
            }
            .background(Color.blackGrayVercel)
        }
        
    }
}

#Preview {
    AuthView(manager: AuthViewModel())
}
