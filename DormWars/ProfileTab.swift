//
//  ProfileTab.swift
//  DormWars
//
//  Created by John Dsouza on 9/26/25.
//

import SwiftUI
import SwiftData

struct ProfileTab: View {
    var body: some View {
        Text("Profile Tab")
            .font(Font.largeTitle)
            .bold(true)
    }
}

#Preview {
    ProfileTab()
        .modelContainer(for: Item.self, inMemory: true)
}
