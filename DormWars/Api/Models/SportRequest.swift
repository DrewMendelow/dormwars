//
//  SportRequest.swift
//  DormWars
//
//  Created by Drew Mendelow on 10/1/25.
//
class SportRequest: Codable {
    var sportName: String
    var description: String?
    var abbreviation: String?
    var playersPerTeam: Int
    
    init(sportName: String, description: String? = nil, abbreviation: String? = nil, playersPerTeam: Int) {
        self.sportName = sportName
        self.description = description
        self.abbreviation = abbreviation
        self.playersPerTeam = playersPerTeam
    }
}
