//
//  ProfileTab.swift
//  DormWars
//
//  Created by John Dsouza on 9/26/25.
//

import SwiftUI
import SwiftData

struct ProfileTab: View {
    @State var schools: String = ""
    var body: some View {
        // Example use of currentUser
//        Text("\(SessionManager.shared.currentUser?.firstName ?? "First") \(SessionManager.shared.currentUser?.lastName ?? "Last")")
        VStack {
            Text(schools)
            Button("get schools") {
                Task {
                    let schoolsList = try await APIService.getSchools();
                    for school in schoolsList {
                        schools += ", \(school.schoolName)"
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileTab()
        .modelContainer(for: Item.self, inMemory: true)
}
