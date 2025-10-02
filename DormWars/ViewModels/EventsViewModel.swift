//
//  EventsViewModel.swift
//  DormWars
//
//  Created by Drew Mendelow on 9/29/25.
//

import Foundation
internal import Combine

@MainActor
class EventsViewModel: ObservableObject {
    
    @Published var events: [Event] = []
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    func fetchEvents() async throws {
        isLoading = true
        events = try await APIService.getEvents()
        isLoading = false
    }
}
