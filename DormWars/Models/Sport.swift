//
//  Sport.swift
//  DormWars
//
//  Created by Drew Mendelow on 9/27/25.
//
class Sport: Codable {
    var sportId: Int
    var sportName: String
    var description: String?
    var abbreviation: String?
    var playersPerTeam: Int
    
    init(sportId: Int, sportName: String, description: String? = nil, abbreviation: String? = nil, playersPerTeam: Int) {
        self.sportId = sportId
        self.sportName = sportName
        self.description = description
        self.abbreviation = abbreviation
        self.playersPerTeam = playersPerTeam
    }
}
