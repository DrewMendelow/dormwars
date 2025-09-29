//
//  ApiService.swift
//  DormWars
//
//  Created by Drew Mendelow on 9/27/25.
//

import Foundation

class APIService {
    let baseURL = URL(string: "http://localhost:8080/api/")!

    // MARK: - Event
    func getEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
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

    func createEvent(_ event: Event, completion: @escaping (Result<Event, Error>) -> Void) {
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
    func getEventTeams(completion: @escaping (Result<[EventTeam], Error>) -> Void) {
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

    func createEventTeam(_ eventTeam: EventTeam, completion: @escaping (Result<EventTeam, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("event-teams")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            let body = try encoder.encode(eventTeam)
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
                let created = try JSONDecoder().decode(EventTeam.self, from: data)
                completion(.success(created))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    // MARK: - RegisterUser
    func getRegisterUsers(completion: @escaping (Result<[RegisterUser], Error>) -> Void) {
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

    func createRegisterUser(_ registerUser: RegisterUser, completion: @escaping (Result<RegisterUser, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("registrations")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            let body = try encoder.encode(registerUser)
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
                let created = try JSONDecoder().decode(RegisterUser.self, from: data)
                completion(.success(created))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    // MARK: - School
    func getSchools(completion: @escaping (Result<[School], Error>) -> Void) {
        let url = baseURL.appendingPathComponent("schools")
        
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
                let schools = try decoder.decode([School].self, from: data)
                completion(.success(schools))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func createSchool(_ school: School, completion: @escaping (Result<School, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("schools")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            let body = try encoder.encode(school)
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
                let created = try JSONDecoder().decode(School.self, from: data)
                completion(.success(created))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    // MARK: - Sport
    func getSports(completion: @escaping (Result<[Sport], Error>) -> Void) {
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

    func createSport(_ sport: Sport, completion: @escaping (Result<Sport, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("sports")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            let body = try encoder.encode(sport)
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
                let created = try JSONDecoder().decode(Sport.self, from: data)
                completion(.success(created))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    // MARK: - Team
    func getTeams(completion: @escaping (Result<[Team], Error>) -> Void) {
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

    func createTeam(_ team: Team, completion: @escaping (Result<Team, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("teams")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            let body = try encoder.encode(team)
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
                let created = try JSONDecoder().decode(Team.self, from: data)
                completion(.success(created))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    // MARK: - Tournament
    func getTournaments(completion: @escaping (Result<[Tournament], Error>) -> Void) {
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

    func createTournament(_ tournament: Tournament, completion: @escaping (Result<Tournament, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("tournaments")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            let body = try encoder.encode(tournament)
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
                let created = try JSONDecoder().decode(Tournament.self, from: data)
                completion(.success(created))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    // MARK: - User
    func getUsers(completion: @escaping (Result<[User], Error>) -> Void) {
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

    func createUser(_ user: User, completion: @escaping (Result<User, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("users")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            let body = try encoder.encode(user)
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
                let created = try JSONDecoder().decode(User.self, from: data)
                completion(.success(created))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

}
