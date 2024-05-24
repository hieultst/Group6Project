//
//  UserManagementView.swift
//  Group6Project
//
//  Created by Trung Hieu on 24/05/2024.
//

import SwiftUI

struct UserManagementView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    private var listOfUsers = userList
    @State private var searchText = ""
    @State private var isEditViewPresented = false
    @State private var selectedUser: User?

    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(viewModel.listUser.indices, id: \.self) { index in
                        let user = viewModel.listUser[index]
                        HStack {
                            VStack(alignment: .leading) {
                                Text(user.fullname)
                                    .font(.headline)
                                    .padding(.bottom, 3)
                                Text(user.email)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .padding(.bottom, 3)
                                HStack {
                                    Text(user.accounttype)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    Button(action: {
                                        self.selectedUser = user
                                        self.isEditViewPresented.toggle()
                                    }) {
                                        Text("Edit")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    .sheet(isPresented: $isEditViewPresented) {
                                        if let selectedUser = selectedUser {
                                            EditView(user: selectedUser)
                                                .navigationTitle("Edit User")
                                                .toolbar {
                                                    ToolbarItem(placement: .navigationBarTrailing) {
                                                        Text("EditView")
                                                            .bold()
                                                    }
                                                }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .searchable(text: $searchText)
            }
            .padding(.horizontal, 16)
            Spacer()
        }
    }
       
    var filteredUsers: [UserTest] {
        let lowercaseSearchText = searchText.lowercased()
        if searchText.isEmpty {
            return listOfUsers
        } else {
            return listOfUsers.filter { user in
                user.userName.lowercased().contains(lowercaseSearchText) ||
                user.email.lowercased().contains(lowercaseSearchText) ||
                user.accountType.lowercased().contains(lowercaseSearchText)
            }
        }
    }
}

struct UserManagementView_Previews: PreviewProvider {
    static var previews: some View {
        UserManagementView()
    }
}
