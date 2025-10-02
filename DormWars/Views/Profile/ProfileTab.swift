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
        // Example use of currentUser
        Text("\(SessionManager.shared.currentUser?.firstName ?? "First") \(SessionManager.shared.currentUser?.lastName ?? "Last")")
    }
}

#Preview {
    ProfileTab()
        .modelContainer(for: Item.self, inMemory: true)
}
