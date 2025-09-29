//
//  RegisterUser.swift
//  DormWars
//
//  Created by Drew Mendelow on 9/27/25.
//
class RegisterUser {
    var registerUserId: Int
    var eventTeam: EventTeam
    var user: User
    
    init(registerUserId: Int, eventTeam: EventTeam, user: User) {
        self.registerUserId = registerUserId
        self.eventTeam = eventTeam
        self.user = user
    }
}
