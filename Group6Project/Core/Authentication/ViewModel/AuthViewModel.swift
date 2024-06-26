//
//  AuthViewModel.swift
//  Group6Project
//
//  Created by Trung Hieu on 21/05/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var listUser: [User] = []
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG: Failed to sign in with error \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullname: String, accouttype: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullname: fullname, email: email, accounttype: accouttype)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut() // signs out user on backend
            self.userSession = nil // wipes out user session and takes us back to login screen
            self.currentUser = nil // wipes out current user data model
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() async {
        guard let user = Auth.auth().currentUser else { return }
        
        do {
            // Delete user document from Firestore
            try await Firestore.firestore().collection("users").document(user.uid).delete()
            
            // Delete user from Firebase Authentication
            try await user.delete()
            
            // Update local state
            self.userSession = nil
            self.currentUser = nil
            
            print("DEBUG: Successfully deleted user account and data")
        } catch {
            print("DEBUG: Failed to delete user account with error \(error.localizedDescription)")
        }
    }
    
    func ressetPassword(withEmail email: String) async throws {
        do {
            // Send email to reset password
            try await Auth.auth().sendPasswordReset(withEmail: email)
            // Print success message (to indicate that the email has been sent)
            print("DEBUG: Password reset email sent successfully.")
        } catch {
            // Handle error if sending password reset email fails
            print("DEBUG: Failed to send password reset email with error \(error.localizedDescription)")
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
    }
    
    func fetchUsers() async {
        do {
            // Lấy tất cả các tài liệu từ bộ sưu tập "users"
            let querySnapshot = try await Firestore.firestore().collection("users").getDocuments()
            
            // Tạo một mảng để lưu trữ danh sách người dùng
            var users: [User] = []
            
            // Lặp qua tất cả các tài liệu và thêm chúng vào mảng users
            for document in querySnapshot.documents {
                // Không cần sử dụng if let vì document.data(as: User.self) không trả về Optional
                let userData = try document.data(as: User.self)
                print("\(userData)")
                users.append(userData)
                
            }
            
            // Gán mảng users đã lấy được cho thuộc tính currentUser
            listUser = users
            print(listUser)
        } catch {
            print("Error fetching users1: \(error.localizedDescription)")
        }
    }
}
