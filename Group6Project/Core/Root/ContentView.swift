//
//  ContentView.swift
//  Group6Project
//
//  Created by Trung Hieu on 21/05/2024.
//

import SwiftUI

@MainActor
struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                ProfileView()
            } else {
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
