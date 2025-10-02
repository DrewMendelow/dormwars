//
//  ContentView.swift
//  DormWars
//
//  Created by Drew Mendelow on 9/24/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        
        TabView {
            EventsTab()
                .tabItem {
                    Image(systemName: "figure.run")
                    Text("Events")
                }
            
            RegisteredTab()
                .tabItem {
                    Image(systemName: "calendar.badge.checkmark")
                    Text("Registered")
                }
            
            ProfileTab()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
