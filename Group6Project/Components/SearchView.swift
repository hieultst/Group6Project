//
//  SearchView.swift
//  Group6Project
//
//  Created by Trung Hieu on 24/05/2024.
//

import SwiftUI

struct SearchView: View {
    private var listOfCountry = ""
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                
            }
            .searchable(text: $searchText)
            .navigationTitle("Users")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
