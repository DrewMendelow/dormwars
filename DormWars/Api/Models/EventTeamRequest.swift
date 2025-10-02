//
//  EventTeamRequest.swift
//  DormWars
//
//  Created by Drew Mendelow on 10/1/25.
//
class EventTeamRequest: Codable {
    var eventId: Int64
    var teamId: Int64
    var isTournamentTeam: Bool
    var tournamentId: Int64?
    var active: Bool
    
    init(eventId: Int64, teamId: Int64, isTournamentTeam: Bool, tournamentId: Int64? = nil, active: Bool) {
        self.eventId = eventId
        self.teamId = teamId
        self.isTournamentTeam = isTournamentTeam
        self.tournamentId = tournamentId
        self.active = active
    }
}

