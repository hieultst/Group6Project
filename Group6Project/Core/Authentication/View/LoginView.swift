//
//  LoginView.swift
//  Group6Project
//
//  Created by Trung Hieu on 21/05/2024.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                // Image
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .padding(.vertical, 32)
                
                // Form fields
                VStack(spacing: 24) {
                    InputView(text: $email,
                              title: "Email Address",
                              placeholder: "name@example.com")
                        .autocapitalization(.none)
                    
                    InputView(text: $password,
                              title: "Password",
                              placeholder: "Enter your password",
                              isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                // Fogot password button
                HStack {
                    Spacer()
                    NavigationLink {
                        RessetPasswordView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text("Forgot Password?")
                            .font(.system(size: 14))
                            .padding(.trailing, 24)
                    }
                    .padding(.top, 12)
                }
                
                // Sign in button
                
                Button {
                    Task {
                        try await viewModel.signIn(withEmail: email, password: password)
                    }
                } label: {
                    HStack {
                        Text("SIGN IN")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemBlue))
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .cornerRadius(10)
                .padding(.top, 24)
                
                Spacer()
            }
        }
    }
}

// MARK: - AuthenticationFormProtocol

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        // Check if the email is not empty
        guard !email.isEmpty else { return false }
        
        // Check if the email contains the @ character
        guard email.contains("@") else { return false }
        
        // Check if the email has a valid domain
        let emailParts = email.split(separator: "@")
        guard emailParts.count == 2 else { return false }
        
        let domainParts = emailParts[1].split(separator: ".")
        guard domainParts.count >= 2 else { return false }
        guard !domainParts.last!.isEmpty else { return false }

        // Check order
        return !password.isEmpty
            && password.count > 5
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
