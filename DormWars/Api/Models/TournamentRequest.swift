//
//  TournamentRequest.swift
//  DormWars
//
//  Created by Drew Mendelow on 10/1/25.
//
class TournamentRequest: Codable {
    var sportId: Int64
    var winnerId: Int64?
    var maxTeams: Int
    var numberOfRounds: Int
    var tournamentName: String
    
    init(sportId: Int64, winnerId: Int64? = nil, maxTeams: Int, numberOfRounds: Int, tournamentName: String) {
        self.sportId = sportId
        self.winnerId = winnerId
        self.maxTeams = maxTeams
        self.numberOfRounds = numberOfRounds
        self.tournamentName = tournamentName
    }
}

