//
//  ContentView.swift
//  Travel KZH
//
//  Created by Julien Widmer on 2022-07-05.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            // MARK: - NavigationView - Currency
            NavigationView {
                CurrencyView()
            }
            .tabItem {
				Symbols.tengesignSquared
                Text("Currency")
            }
            // MARK: - NavigationView - Vocabulary
            NavigationView {
                VocabularyView()
            }
            .tabItem {
				Symbols.twoPersonsWithWaveFilled
                Text("Vocabulary")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
