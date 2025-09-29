//
//  EventTeam.swift
//  DormWars
//
//  Created by Drew Mendelow on 9/27/25.
//
class EventTeam: Codable {
    var eventTeamId: Int
    var eventId: Int
    var team: Team
    var isTournamentTeam: Bool
    var tournament: Tournament?
    var active: Bool
    
    init(eventTeamId: Int, eventId: Int, team: Team, isTournamentTeam: Bool, tournament: Tournament? = nil, active: Bool) {
        self.eventTeamId = eventTeamId
        self.eventId = eventId
        self.team = team
        self.isTournamentTeam = isTournamentTeam
        self.tournament = tournament
        self.active = active
    }
}

