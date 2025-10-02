//
//  ProfileTab.swift
//  DormWars
//
//  Created by John Dsouza on 9/26/25.
//

import SwiftUI
import SwiftData

struct ProfileTab: View {
    @State var events: String = ""
    @State var eventTeams: String = ""
    @State var registerUser: String = ""
    @State var schools: String = ""
    @State var sports: String = ""
    @State var teams: String = ""
    @State var tournaments: String = ""
    @State var users: String = ""
    var body: some View {
        // Example use of currentUser
//        Text("\(SessionManager.shared.currentUser?.firstName ?? "First") \(SessionManager.shared.currentUser?.lastName ?? "Last")")
        VStack {
            Text(events)
            Text(eventTeams)
            Text(registerUser)
            Text(schools)
            Text(sports)
            Text(teams)
            Text(tournaments)
            Text(users)
            Button("get schools") {
                Task {
                    print("events")
                    let eventList = try await APIService.getEvents();
                    for school in eventList {
                        events += ", \(school.eventName)"
                    }
                    print("event teams")
                    let eventTeamList = try await APIService.getEventTeams();
                    for school in eventTeamList {
                        eventTeams += ", \(school.eventTeamId)"
                    }
                    print("register users")
                    let registerList = try await APIService.getRegisterUsers();
                    for school in registerList {
                        registerUser += ", \(school.registerUserId)"
                    }
                    print("schools")
                    let schoolList = try await APIService.getSchools();
                    for school in schoolList {
                        schools += ", \(school.schoolName)"
                    }
                    print("sports")
                    let sportList = try await APIService.getSports();
                    for school in sportList {
                        sports += ", \(school.sportName)"
                    }
                    print("teams")
                    let teamList = try await APIService.getTeams();
                    for school in teamList {
                        teams += ", \(school.teamName)"
                    }
                    print("tournaments")
                    let tournamentList = try await APIService.getTournaments();
                    for school in tournamentList {
                        tournaments += ", \(school.tournamentId)"
                    }
                    print("users")
                    let userList = try await APIService.getUsers();
                    for school in userList {
                        users += ", \(school.firstName)"
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
