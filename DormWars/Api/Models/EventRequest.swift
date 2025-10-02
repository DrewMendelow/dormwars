//
//  EventRequest.swift
//  DormWars
//
//  Created by Drew Mendelow on 10/1/25.
//

import Foundation

class EventRequest: Codable {
    var location: String?
    var datetime: Date
    var sportId: Int64
    var isTournamentGame: Bool
    var status: String
    var shortDescription: String
    var longDescription: String
    var winnerId: Int64?
    var loserId: Int64?
    var tournamentId: Int64?
    var roundNumber: Int?
    var nextEventId: Int64?
    var eventName: String
    
    init(location: String? = nil, datetime: Date, sportId: Int64, isTournamentGame: Bool, status: String, shortDescription: String, longDescription: String, winnerId: Int64? = nil, loserId: Int64? = nil, tournamentId: Int64? = nil, roundNumber: Int? = nil, nextEventId: Int64? = nil, eventName: String) {
        self.location = location
        self.datetime = datetime
        self.sportId = sportId
        self.isTournamentGame = isTournamentGame
        self.status = status
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.winnerId = winnerId
        self.loserId = loserId
        self.tournamentId = tournamentId
        self.roundNumber = roundNumber
        self.nextEventId = nextEventId
        self.eventName = eventName
    }
}

