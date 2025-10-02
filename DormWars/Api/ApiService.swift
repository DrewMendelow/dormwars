//
//  ApiService.swift
//  DormWars
//
//  Created by Drew Mendelow on 9/27/25.
//

import Foundation

class APIService {
    static let baseURL = URL(string: "https://dormwarsapi.onrender.com/api/")!

    // MARK: - Event
    static func getEvents() async throws -> [Event] {
        let url = baseURL.appendingPathComponent("events")
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        decoder.dateDecodingStrategy = .formatted(formatter)
        return try decoder.decode([Event].self, from: data)
    }

    static func createEvent(
        datetime: Date,
        sportId: Int64,
        isTournamentGame: Bool,
        status: String,
        shortDescription: String,
        longDescription: String,
        eventName: String,
        location: String? = nil,
        winnerId: Int64? = nil,
        loserId: Int64? = nil,
        tournamentId: Int64? = nil,
        roundNumber: Int? = nil,
        nextEventId: Int64? = nil,
    ) async throws -> Bool {
        let req = EventRequest(
            location: location,
            datetime: datetime,
            sportId: sportId,
            isTournamentGame: isTournamentGame,
            status: status,
            shortDescription: shortDescription,
            longDescription: longDescription,
            winnerId: winnerId,
            loserId: loserId,
            tournamentId: tournamentId,
            roundNumber: roundNumber,
            nextEventId: nextEventId,
            eventName: eventName
        )
        
        let url = baseURL.appendingPathComponent("events")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let body = try encoder.encode(req)
            request.httpBody = body
        } catch {
            return false
        }

        let (_, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            return false
        }

        return (200...299).contains(httpResponse.statusCode)
    }

    // MARK: - EventTeam
    static func getEventTeams() async throws -> [EventTeam] {
        let url = baseURL.appendingPathComponent("event-teams")
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode([EventTeam].self, from: data)
    }

    static func createEventTeam(
        eventId: Int64? = nil,
        teamId: Int64,
        isTournamentTeam: Bool,
        active: Bool,
        tournamentId: Int64? = nil,
    ) async throws -> Bool {
        let req = EventTeamRequest(
            eventId: eventId,
            teamId: teamId,
            isTournamentTeam: isTournamentTeam,
            tournamentId: tournamentId,
            active: active
        )

        let url = baseURL.appendingPathComponent("event-teams")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(req)

        let (_, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            return false
        }

        return (200...299).contains(httpResponse.statusCode)
    }


    // MARK: - RegisterUser
    static func getRegisterUsers() async throws -> [RegisterUser] {
        let url = baseURL.appendingPathComponent("registrations")
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode([RegisterUser].self, from: data)
    }

    static func createRegisterUser(
        eventTeamId: Int64,
        userId: Int64,
    ) async throws -> Bool {
        let req = RegisterUserRequest(eventTeamId: eventTeamId, userId: userId)
        let url = baseURL.appendingPathComponent("registrations")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(req)

        let (_, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            return false
        }

        return (200...299).contains(httpResponse.statusCode)
    }


    // MARK: - School
    static func getSchools() async throws -> [School] {
        let url = baseURL.appendingPathComponent("schools")
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode([School].self, from: data)
    }

    static func createSchool(
        schoolName: String,
        active: Bool,
        city: String? = nil,
        state: String? = nil,
        primaryColor: String? = nil,
        secondaryColor: String? = nil,
        schoolLogo: String? = nil,
    ) async throws -> Bool {
        let req = SchoolRequest(
            schoolName: schoolName,
            city: city,
            state: state,
            primaryColor: primaryColor,
            secondaryColor: secondaryColor,
            schoolLogo: schoolLogo,
            active: active
        )

        let url = baseURL.appendingPathComponent("schools")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(req)

        let (_, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            return false
        }

        return (200...299).contains(httpResponse.statusCode)
    }


    // MARK: - Sport
    static func getSports() async throws -> [Sport] {
        let url = baseURL.appendingPathComponent("sports")
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode([Sport].self, from: data)
    }

    static func createSport(
        sportName: String,
        playersPerTeam: Int,
        description: String? = nil,
        abbreviation: String? = nil,
    ) async throws -> Bool {
        let req = SportRequest(
            sportName: sportName,
            description: description,
            abbreviation: abbreviation,
            playersPerTeam: playersPerTeam
        )

        let url = baseURL.appendingPathComponent("sports")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(req)

        let (_, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            return false
        }

        return (200...299).contains(httpResponse.statusCode)
    }


    // MARK: - Team
    static func getTeams() async throws -> [Team] {
        let url = baseURL.appendingPathComponent("teams")
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode([Team].self, from: data)
    }

    static func createTeam(
        teamName: String,
        schoolId: Int64,
        active: Bool,
    ) async throws -> Bool {
        let req = TeamRequest(teamName: teamName, schoolId: schoolId, active: active)

        let url = baseURL.appendingPathComponent("teams")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(req)

        let (_, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            return false
        }

        return (200...299).contains(httpResponse.statusCode)
    }


    // MARK: - Tournament
    static func getTournaments() async throws -> [Tournament] {
        let url = baseURL.appendingPathComponent("tournaments")
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode([Tournament].self, from: data)
    }

    static func createTournament(
        sportId: Int64,
        maxTeams: Int,
        numberOfRounds: Int,
        winnerId: Int64? = nil,
        tournamentName: String
    ) async throws -> Bool {
        let req = TournamentRequest(
            sportId: sportId,
            winnerId: winnerId,
            maxTeams: maxTeams,
            numberOfRounds: numberOfRounds,
            tournamentName: tournamentName
        )

        let url = baseURL.appendingPathComponent("tournaments")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(req)

        let (_, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            return false
        }

        return (200...299).contains(httpResponse.statusCode)
    }



    // MARK: - User
    static func getUsers() async throws -> [User] {
        let url = baseURL.appendingPathComponent("users")
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode([User].self, from: data)
    }

    static func createUser(
        firstName: String,
        lastName: String,
        email: String,
        schoolId: Int64,
        userType: String,
        phoneNumber: String? = nil,
    ) async throws -> Bool {
        let req = UserRequest(
            firstName: firstName,
            lastName: lastName,
            email: email,
            phoneNumber: phoneNumber,
            schoolId: schoolId,
            userType: userType
        )

        let url = baseURL.appendingPathComponent("users")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(req)

        let (_, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            return false
        }

        return (200...299).contains(httpResponse.statusCode)
    }
}

