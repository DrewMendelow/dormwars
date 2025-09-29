//
//  ApiService.swift
//  DormWars
//
//  Created by Drew Mendelow on 9/27/25.
//

import Foundation

class APIService {
    let baseURL = URL(string: "http://localhost:8080/api/")!

    func fetchEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
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
}
