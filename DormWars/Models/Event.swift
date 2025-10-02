//
//  Event.swift
//  DormWars
//
//  Created by Drew Mendelow on 9/27/25.
//

import Foundation

class Event: Codable {
    var eventId: Int64
    var location: String?
    var datetime: Date
    var sport: Sport
    var isTournamentGame: Bool
    var status: String
    var shortDescription: String
    var longDescription: String
    var winner: EventTeam?
    var loser: EventTeam?
    var tournament: Tournament?
    var roundNumber: Int?
    var nextEventId: Int64?
    var eventName: String
    
    init(eventId: Int64, location: String? = nil, datetime: Date, sport: Sport, isTournamentGame: Bool, status: String, shortDescription: String, longDescription: String, winner: EventTeam? = nil, loser: EventTeam? = nil, tournament: Tournament? = nil, roundNumber: Int? = nil, nextEventId: Int64? = nil, eventName: String) {
        self.eventId = eventId
        self.location = location
        self.datetime = datetime
        self.sport = sport
        self.isTournamentGame = isTournamentGame
        self.status = status
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.winner = winner
        self.loser = loser
        self.tournament = tournament
        self.roundNumber = roundNumber
        self.nextEventId = nextEventId
        self.eventName = eventName
    }
}

