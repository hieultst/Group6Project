//
//  RessetPasswordView.swift
//  Group6Project
//
//  Created by Trung Hieu on 22/05/2024.
//

import SwiftUI

struct RessetPasswordView: View {
    @State private var email = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToLogin = false
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    
    var body: some View {
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
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            
            // Resset Password button
            Button {
                Task {
                    do {
                        try await viewModel.ressetPassword(withEmail: email)
                        showAlert = true
                        alertMessage = "Password reset email sent successfully."
                    } catch {
                        showAlert = true
                        alertMessage = "Failed to reset password. \(error.localizedDescription)"
                    }
                }
            } label: {
                HStack {
                    Text("Resset Password")
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
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Back to login")
                }
                .font(.system(size: 14))
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Success"), message: Text(alertMessage), dismissButton: .default(Text("OK"), action: {
                dismiss()
            }))
        }
    }
}

// MARK: - AuthenticationFormProtocol
extension RessetPasswordView: AuthenticationFormProtocol {
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
        return true
    }
}

struct RessetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        RessetPasswordView()
    }
}
