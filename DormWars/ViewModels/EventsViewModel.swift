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
    
    func fetchEvents() {
        isLoading = true
        APIService.getEvents { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let events):
                    self.events = events
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
                self.isLoading = false
            }
        }
    }
}
