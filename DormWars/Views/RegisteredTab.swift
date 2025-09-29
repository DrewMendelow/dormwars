//
//  RegisteredTab.swift
//  DormWars
//
//  Created by John Dsouza on 9/26/25.
//

import SwiftUI
import SwiftData

struct RegisteredTab: View {
    var body: some View {
        Text("Registered Tab")
    }
}

#Preview {
    RegisteredTab()
        .modelContainer(for: Item.self, inMemory: true)
}
