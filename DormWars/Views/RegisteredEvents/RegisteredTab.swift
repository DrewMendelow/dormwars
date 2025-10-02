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
                APIService.createTeam(teamName: "Smith", schoolId: 1, active: true, completion: { _ in })
            }
            Button("Create Register User") {
                APIService.createRegisterUser(eventTeamId: 1, userId: 1, completion: {_ in })
            }
            Button("Create School") {
                APIService.createSchool(schoolName: "Georgia", active: false, completion: {_ in })
            }
            Button("Create Sport") {
                APIService.createSport(sportName: "Ping Pong", playersPerTeam: 2, completion: {_ in })
            }
            Button("Create Tournament") {
                APIService.createTournament(sportId: 1, maxTeams: 8, numberOfRounds: 4, completion: {_ in })
            }
            Button("Create User") {
                APIService.createUser(firstName: "Wow", lastName: "Grape", email: "grappe@gmail.com", schoolId: 1, userType: "player", completion: {_ in })
            }
            Button("Create Event") {
                APIService.createEvent(datetime: Date(), sportId: 2, isTournamentGame: false, status: "upcoming", shortDescription: "Flag Football 7v7", longDescription: "Flag Football Game between Field and Smith", eventName: "Field v Smith Flag Football", completion: {_ in})
            }
        }
    }
}

#Preview {
    RegisteredTab()
        .modelContainer(for: Item.self, inMemory: true)
}

