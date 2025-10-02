//
//  Tournament.swift
//  DormWars
//
//  Created by Drew Mendelow on 9/27/25.
//
class Tournament: Codable {
    var tournamentId: Int64
    var sport: Sport
    var winner: EventTeam?
    var maxTeams: Int
    var numberOfRounds: Int
    
    init(tournamentId: Int64, sport: Sport, winner: EventTeam? = nil, maxTeams: Int, numberOfRounds: Int) {
        self.tournamentId = tournamentId
        self.sport = sport
        self.winner = winner
        self.maxTeams = maxTeams
        self.numberOfRounds = numberOfRounds
    }
}

