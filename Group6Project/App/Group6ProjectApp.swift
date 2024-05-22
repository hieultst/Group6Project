//
//  Group6ProjectApp.swift
//  Group6Project
//
//  Created by Trung Hieu on 21/05/2024.
//

import SwiftUI
import Firebase

@main
struct Group6ProjectApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
