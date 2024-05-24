//
//  ProfileView.swift
//  Group6Project
//
//  Created by Trung Hieu on 21/05/2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var isUserManagementActive = false
    @State private var isUserRegierActive = false
    
    
    var body: some View {
        if let user = viewModel.currentUser {
            NavigationView {
                List {
                    Section {
                        HStack {
                            Text(user.initials)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 72, height: 72)
                                .background(Color(.systemGray3))
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(user.fullname)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .padding(.top, 4)
                                
                                Text(user.email)
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                
                            }
                        }
                    }
                    
                    Section("General") {
                        HStack {
                            SettingsRowView(imageName: "gear",
                                            title: "Version",
                                            tintColor: Color(.systemGray))
                            Spacer()
                            
                            Text("1.0.0")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Section("Account") {
                        HStack {
                            SettingsRowView(imageName: "person.crop.circle.fill",
                                            title: "Admin",
                                            tintColor: Color(.systemGray))
                        }
                        
                        // Button to navigate to UserManagementView
                        Button(action: {
                            Task {
                                await viewModel.fetchUsers() // Gọi hàm fetchUsers từ viewModel
                                isUserManagementActive = true // Set the state variable to true để kích hoạt NavigationLink
                            }
                        }) {
                            SettingsRowView(imageName: "person.2.fill",
                                            title: "Users",
                                            tintColor: Color(.systemGray))
                        }
                        .background(
                            NavigationLink(
                                destination: UserManagementView().environmentObject(viewModel), // Destination view
                                isActive: $isUserManagementActive, // Binding to control the NavigationLink activation
                                label: { EmptyView() } // EmptyView is used as label
                            ).hidden() // Hide the NavigationLink
                        )
                        
                        
                        Button {
                            Task {
                                // Chuyen huong sang product
                            }
                            //                        print("ProductsView")
                        } label: {
                            SettingsRowView(imageName: "cube.box.fill",
                                            title: "Products",
                                            tintColor: Color(.systemGray))
                        }
                        
                        Button {
                            print("RevenueView")
                        } label: {
                            SettingsRowView(imageName: "dollarsign.circle.fill",
                                            title: "Revenue",
                                            tintColor: Color(.systemGray))
                        }
                        Button {
                            viewModel.signOut()
                        } label: {
                            SettingsRowView(imageName: "arrow.left.circle.fill",
                                            title: "Sign Out",
                                            tintColor: .red)
                        }
                    }
                    
                    Section("Options") {
                        // Button to navigate to UserManagementView
                        Button(action: {
                            isUserRegierActive = true // Set the state variable to true to activate NavigationLink
                        }) {
                            SettingsRowView(imageName: "plus.circle.fill",
                                            title: "Create New User",
                                            tintColor: Color(.systemGray))
                        }
                        .background(
                            NavigationLink(
                                destination: RegistrationView(), // Destination view
                                isActive: $isUserRegierActive, // Binding to control the NavigationLink activation
                                label: { EmptyView() } // EmptyView is used as label
                            ).hidden() // Hide the NavigationLink
                        )
                    }
                }
                .navigationTitle("Profile")
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
