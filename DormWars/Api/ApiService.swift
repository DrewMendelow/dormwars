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
    static func getEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
        let url = baseURL.appendingPathComponent("events")

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1)))
                return
            }

            do {
                let decoder = JSONDecoder()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                formatter.timeZone = TimeZone(secondsFromGMT: 0)
                decoder.dateDecodingStrategy = .formatted(formatter)
                
                let events = try decoder.decode([Event].self, from: data)
                completion(.success(events))
            } catch {
                completion(.failure(error))
            }
        }.resume()
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
        completion: @escaping (Result<Event, Error>) -> Void
    ) {
        let event = EventRequest(
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
            let body = try encoder.encode(event)
            request.httpBody = body
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1)))
                return
            }

            do {
                let createdEvent = try JSONDecoder().decode(Event.self, from: data)
                completion(.success(createdEvent))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    // MARK: - EventTeam
    static func getEventTeams(completion: @escaping (Result<[EventTeam], Error>) -> Void) {
        let url = baseURL.appendingPathComponent("event-teams")
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1)))
                return
            }
            do {
                let decoder = JSONDecoder()
                let eventTeams = try decoder.decode([EventTeam].self, from: data)
                completion(.success(eventTeams))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    static func createEventTeam(
        eventId: Int64,
        teamId: Int64,
        isTournamentTeam: Bool,
        active: Bool,
        tournamentId: Int64? = nil,
        completion: @escaping (Result<EventTeam, Error>) -> Void
    ) {
        let eventTeamReq = EventTeamRequest(
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

        do {
            request.httpBody = try JSONEncoder().encode(eventTeamReq)
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error { completion(.failure(error)); return }
            guard let data = data else { completion(.failure(NSError(domain: "No data", code: -1))); return }
            do {
                let created = try JSONDecoder().decode(EventTeam.self, from: data)
                completion(.success(created))
            } catch { completion(.failure(error)) }
        }.resume()
    }


    // MARK: - RegisterUser
    static func getRegisterUsers(completion: @escaping (Result<[RegisterUser], Error>) -> Void) {
        let url = baseURL.appendingPathComponent("registrations")
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1)))
                return
            }
            do {
                let decoder = JSONDecoder()
                let users = try decoder.decode([RegisterUser].self, from: data)
                completion(.success(users))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    static func createRegisterUser(
        eventTeamId: Int64,
        userId: Int64,
        completion: @escaping (Result<RegisterUser, Error>) -> Void
    ) {
        let req = RegisterUserRequest(eventTeamId: eventTeamId, userId: userId)
        let url = baseURL.appendingPathComponent("registrations")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do { request.httpBody = try JSONEncoder().encode(req) }
        catch { completion(.failure(error)); return }

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error { completion(.failure(error)); return }
            guard let data = data else { completion(.failure(NSError(domain: "No data", code: -1))); return }
            do {
                let created = try JSONDecoder().decode(RegisterUser.self, from: data)
                completion(.success(created))
            } catch { completion(.failure(error)) }
        }.resume()
    }


    // MARK: - School
    static func getSchools() async throws -> [School] {
        let url = baseURL.appendingPathComponent("schools")
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode([School].self, from: data)
    }

//    static func getSchools() -> [School] {
//        let url = baseURL.appendingPathComponent("schools")
//        
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            if let error = error {
////                completion(.failure(error))
//                return
//            }
//            guard let data = data else {
////                completion(.failure(NSError(domain: "No data", code: -1)))
//                return
//            }
//            do {
//                let decoder = JSONDecoder()
//                let schools = try decoder.decode([School].self, from: data)
//                return schools
////                completion(.success(schools))
//            } catch {
//                return []
////                completion(.failure(error))
//            }
//        }.resume()
//    }

    static func createSchool(
        schoolName: String,
        active: Bool,
        city: String? = nil,
        state: String? = nil,
        primaryColor: String? = nil,
        secondaryColor: String? = nil,
        schoolLogo: String? = nil,
        completion: @escaping (Result<School, Error>) -> Void
    ) {
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

        do { request.httpBody = try JSONEncoder().encode(req) }
        catch { completion(.failure(error)); return }

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error { completion(.failure(error)); return }
            guard let data = data else { completion(.failure(NSError(domain: "No data", code: -1))); return }
            do {
                let created = try JSONDecoder().decode(School.self, from: data)
                completion(.success(created))
            } catch { completion(.failure(error)) }
        }.resume()
    }


    // MARK: - Sport
    static func getSports(completion: @escaping (Result<[Sport], Error>) -> Void) {
        let url = baseURL.appendingPathComponent("sports")
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1)))
                return
            }
            do {
                let decoder = JSONDecoder()
                let sports = try decoder.decode([Sport].self, from: data)
                completion(.success(sports))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    static func createSport(
        sportName: String,
        playersPerTeam: Int,
        description: String? = nil,
        abbreviation: String? = nil,
        completion: @escaping (Result<Sport, Error>) -> Void
    ) {
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

        do { request.httpBody = try JSONEncoder().encode(req) }
        catch { completion(.failure(error)); return }

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error { completion(.failure(error)); return }
            guard let data = data else { completion(.failure(NSError(domain: "No data", code: -1))); return }
            do {
                let created = try JSONDecoder().decode(Sport.self, from: data)
                completion(.success(created))
            } catch { completion(.failure(error)) }
        }.resume()
    }


    // MARK: - Team
    static func getTeams(completion: @escaping (Result<[Team], Error>) -> Void) {
        let url = baseURL.appendingPathComponent("teams")
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1)))
                return
            }
            do {
                let decoder = JSONDecoder()
                let teams = try decoder.decode([Team].self, from: data)
                completion(.success(teams))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    static func createTeam(
        teamName: String,
        schoolId: Int64,
        active: Bool,
        completion: @escaping (Result<Team, Error>) -> Void
    ) {
        let req = TeamRequest(teamName: teamName, schoolId: schoolId, active: active)

        let url = baseURL.appendingPathComponent("teams")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do { request.httpBody = try JSONEncoder().encode(req) }
        catch { completion(.failure(error)); return }

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error { completion(.failure(error)); return }
            guard let data = data else { completion(.failure(NSError(domain: "No data", code: -1))); return }
            do {
                let created = try JSONDecoder().decode(Team.self, from: data)
                completion(.success(created))
            } catch { completion(.failure(error)) }
        }.resume()
    }


    // MARK: - Tournament
    static func getTournaments(completion: @escaping (Result<[Tournament], Error>) -> Void) {
        let url = baseURL.appendingPathComponent("tournaments")
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1)))
                return
            }
            do {
                let decoder = JSONDecoder()
                let tournaments = try decoder.decode([Tournament].self, from: data)
                completion(.success(tournaments))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    static func createTournament(
        sportId: Int64,
        maxTeams: Int,
        numberOfRounds: Int,
        winnerId: Int64? = nil,
        completion: @escaping (Result<Tournament, Error>) -> Void
    ) {
        let req = TournamentRequest(sportId: sportId, winnerId: winnerId, maxTeams: maxTeams, numberOfRounds: numberOfRounds)

        let url = baseURL.appendingPathComponent("tournaments")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do { request.httpBody = try JSONEncoder().encode(req) }
        catch { completion(.failure(error)); return }

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error { completion(.failure(error)); return }
            guard let data = data else { completion(.failure(NSError(domain: "No data", code: -1))); return }
            do {
                let created = try JSONDecoder().decode(Tournament.self, from: data)
                completion(.success(created))
            } catch { completion(.failure(error)) }
        }.resume()
    }


    // MARK: - User
    static func getUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        let url = baseURL.appendingPathComponent("users")
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1)))
                return
            }
            do {
                let decoder = JSONDecoder()
                let users = try decoder.decode([User].self, from: data)
                completion(.success(users))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    static func createUser(
        firstName: String,
        lastName: String,
        email: String,
        schoolId: Int64,
        userType: String,
        phoneNumber: String? = nil,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
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

        do { request.httpBody = try JSONEncoder().encode(req) }
        catch { completion(.failure(error)); return }

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error { completion(.failure(error)); return }
            guard let data = data else { completion(.failure(NSError(domain: "No data", code: -1))); return }
            do {
                let created = try JSONDecoder().decode(User.self, from: data)
                completion(.success(created))
            } catch { completion(.failure(error)) }
        }.resume()
    }
}

