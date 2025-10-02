//
//  RegisterUser.swift
//  DormWars
//
//  Created by Drew Mendelow on 9/27/25.
//
class RegisterUser: Codable {
    var registerUserId: Int64
    var eventTeam: EventTeam
    var user: User
    
    init(registerUserId: Int64, eventTeam: EventTeam, user: User) {
        self.registerUserId = registerUserId
        self.eventTeam = eventTeam
        self.user = user
    }
}
