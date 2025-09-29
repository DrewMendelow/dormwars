//
//  Team.swift
//  DormWars
//
//  Created by Drew Mendelow on 9/27/25.
//
class Team: Codable {
    var teamId: Int64
    var teamName: String
    var school: School
    var active: Bool
    
    init(teamId: Int64, teamName: String, school: School, active: Bool) {
        self.teamId = teamId
        self.teamName = teamName
        self.school = school
        self.active = active
    }
}

