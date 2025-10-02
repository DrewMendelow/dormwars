//
//  RegistrationViewModel.swift
//  DormWars
//
//  Created by John Dsouza on 10/1/25.
//

import Foundation
internal import Combine

@MainActor
class RegistrationViewModel: ObservableObject {
    
    @Published private(set) var registrations: [RegisterUser] = []
    
    func register(user: User, eventTeam: EventTeam) async throws {
        guard try await !isRegistered(user: user, eventTeam: eventTeam) else {
            print("User \(user.firstName) \(user.lastName) is already registered for team \(eventTeam.team.teamName)")
            return
        }
        
        APIService.createRegisterUser(eventTeamId: eventTeam.eventTeamId, userId: user.userId, completion: {_ in})
        
        print("User \(user.firstName) \(user.lastName) has been registered for team \(eventTeam.team.teamName)")
    }
    
    func isRegistered(user: User, eventTeam: EventTeam) async throws -> Bool {
        return try await APIService.getRegisterUsers().contains(where: { reg in
            reg.user.userId == user.userId && reg.eventTeam.eventTeamId == eventTeam.eventTeamId
        })
    }
    
    func unregister(user: User, eventTeam: EventTeam) {
        registrations.removeAll { reg in
            reg.user.userId == user.userId && reg.eventTeam.eventTeamId == eventTeam.eventTeamId
        }
        print("User \(user.firstName) \(user.lastName) unregistered from team \(eventTeam.team.teamName)")
    }
}
