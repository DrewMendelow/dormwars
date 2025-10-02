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
    
    @Published private(set) var registrations: [RegisterUserRequest] = []
    
    func register(user: User, eventTeam: EventTeam) {
        guard !isRegistered(user: user, eventTeam: eventTeam) else {
            print("User \(user.firstName) \(user.lastName) is already registered for team \(eventTeam.team.teamName)")
            return
        }
            
        
        let registration = RegisterUserRequest(eventTeamId: eventTeam.eventTeamId, userId: user.userId)
        registrations.append(registration)
        
        print("User \(user.firstName) \(user.lastName) has been registered for team \(eventTeam.team.teamName)")
    }
    
    func isRegistered(user: User, eventTeam: EventTeam) -> Bool {
        return registrations.contains(where: { reg in
            reg.userId == user.userId && reg.eventTeamId == eventTeam.eventTeamId
        })
    }
    
    func unregister(user: User, eventTeam: EventTeam) {
        registrations.removeAll { reg in
            reg.userId == user.userId && reg.eventTeamId == eventTeam.eventTeamId
        }
        print("User \(user.firstName) \(user.lastName) unregistered from team \(eventTeam.team.teamName)")
    }
}
