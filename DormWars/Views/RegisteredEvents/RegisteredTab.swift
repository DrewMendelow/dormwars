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
//        Text("Registered Tab")
        VStack {
            Button("Create Team") {
                Task {
                    try await APIService.createTeam(teamName: "Harrison", schoolId: 1, active: true)
                }
            }
            Button("Create Register User") {
                Task {
                    try await APIService.createRegisterUser(eventTeamId: 2, userId: 1)
                }
            }
            Button("Create School") {
                Task {
                    try await APIService.createSchool(schoolName: "Georgia State", active: true)
                }
            }
            Button("Create Sport") {
                Task {
                    try await APIService.createSport(sportName: "Tug of War", playersPerTeam: 50)
                }
            }
            Button("Create Tournament") {
                Task {
                    try await APIService.createTournament(sportId: 2, maxTeams: 8, numberOfRounds: 4, tournamentName: "Flag Football Tournament")
                }
            }
            Button("Create User") {
                Task {
                    try await APIService.createUser(firstName: "test", lastName: "test", email: "test@gmail.com", schoolId: 1, userType: "player")
                }
            }
            Button("Create Event") {
                Task {
                    try await APIService.createEvent(datetime: Date(), sportId: 1, isTournamentGame: false, status: "upcoming", shortDescription: "Test soccer event", longDescription: "Flag Football Game between Field and Smith", eventName: "test event")
                }
            }
            Button("Create Event Team") {
                Task {
                    try await APIService.createEventTeam(teamId: 3, isTournamentTeam: true, active: true, tournamentId: 3)
                }
            }
        }
    }
}

#Preview {
    RegisteredTab()
        .modelContainer(for: Item.self, inMemory: true)
}

