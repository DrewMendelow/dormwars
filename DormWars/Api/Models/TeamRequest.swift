//
//  TeamRequest.swift
//  DormWars
//
//  Created by Drew Mendelow on 10/1/25.
//
class TeamRequest: Codable {
    var teamName: String
    var schoolId: Int64
    var active: Bool
    
    init(teamName: String, schoolId: Int64, active: Bool) {
        self.teamName = teamName
        self.schoolId = schoolId
        self.active = active
    }
}

