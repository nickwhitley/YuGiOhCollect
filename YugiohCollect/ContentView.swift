//
//  ContentView.swift
//  YugiohCollect
//
//  Created by nwhitley.vendor on 6/3/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
//        ZStack {
//            CardListView()
//        }
        TabView {
            CardListView()
                .tabItem {
                    Label("Cards", systemImage: "greetingcard")
                }
            GamesView()
                .tabItem {
                    Label("Games", systemImage: "arcade.stick")
                }
            CollectionView()
                .tabItem {
                    Label("Collection", systemImage: "plus.rectangle")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}


#Preview {
    ContentView()
        .modelContainer(for: Card.self)
}
