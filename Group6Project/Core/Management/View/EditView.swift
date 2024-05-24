//
//  EditView.swift
//  Group6Project
//
//  Created by Trung Hieu on 24/05/2024.
//

import SwiftUI

struct EditView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel
   @State private var editedUserName: String
   @State private var editedAccountType: String

   let user: User

   init(user: User) {
       self.user = user
       self._editedUserName = State(initialValue: user.fullname)
       self._editedAccountType = State(initialValue: user.accounttype)
   }

   var body: some View {
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
               
               Section("Accout") {
                   HStack {
                       SettingsRowView(imageName: "person.crop.circle.fill",
                                       title: "Admin",
                                       tintColor: Color(.systemGray))
                   }
               }
               
               VStack(spacing: 24) {
                   InputView(text: $editedUserName,
                             title: "Full Name",
                             placeholder: "Enter your name")
                   InputView(text: $editedAccountType,
                             title: "Account Type",
                             placeholder: "Enter account type")
               }
               .padding(.top, 8)
               
               Section("Account") {
                   Button {
                       print("Delete")
                   } label: {
                       SettingsRowView(imageName: "pencil.circle.fill",
                                       title: "Update",
                                       tintColor: Color(.systemGray))
                   }
                   
                   Button {
                       Task {
                           await viewModel.deleteAccount()
                       }
                   } label: {
                       SettingsRowView(imageName: "xmark.circle.fill",
                                       title: "Delete Account",
                                       tintColor: .red)
                   }
               }
           }
       }
   }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(user: User(id: NSUUID().uuidString, fullname: "Le Trung Hieu", email: "leetrunghieu@example.com", accounttype: "Admin"))
    }
}
