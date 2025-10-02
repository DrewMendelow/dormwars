//
//  RegisterUserRequest.swift
//  DormWars
//
//  Created by Drew Mendelow on 10/1/25.
//
class RegisterUserRequest: Codable {
    var eventTeamId: Int64
    var userId: Int64
    
    init(eventTeamId: Int64, userId: Int64) {
        self.eventTeamId = eventTeamId
        self.userId = userId
    }
}

