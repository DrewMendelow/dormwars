//
//  EventsTab.swift
//  DormWars
//
//  Created by John Dsouza on 9/26/25.
//

import SwiftUI
import SwiftData

struct EventsTab: View {
    @State private var searchText: String = ""
    @State private var filterCategory: String = "All"
    @State private var selectedEvent: Event?
    @StateObject private var viewModel = EventsViewModel()

    let categories = ["All", "Tournament", "Game"]

    var filteredEvents: [Event] {
        viewModel.events.filter { event in
            let categoryMatches: Bool = {
                switch filterCategory {
                case "Tournament":
                    return event.isTournamentGame
                case "Game":
                    return !event.isTournamentGame
                default:
                    return true
                }
            }()
            let searchMatches = searchText.isEmpty || event.shortDescription.localizedCaseInsensitiveContains(searchText) || event.longDescription.localizedCaseInsensitiveContains(searchText)
            return categoryMatches && searchMatches
        }
    }

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                let cardSize = geometry.size.width * 0.9
                let barHeight = cardSize * 0.20

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {

                        // MARK: - Page Header
                        VStack(alignment: .leading, spacing: 6) {
                            Text("DormWars Events")
                                .font(.largeTitle.bold())
                            Text("Check out all upcoming competitions and activities")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)

                        // MARK: - Search + Filter
                        EventSearchFilterBar(searchText: $searchText, filterCategory: $filterCategory, categories: categories)

                        // MARK: - Event Cards
                        if viewModel.isLoading {
                            ProgressView()
                        } else {
                            ForEach(filteredEvents, id: \.eventId) { event in
                                EventCard(event: event, selectedEvent: $selectedEvent, barHeight: barHeight, cardSize: cardSize)
                            }
                        }
                    }
                    .padding(.vertical, 32)
                }
                .onAppear {
                    Task {
                        try await viewModel.fetchEvents()
                    }
                }

                // MARK: - Event Detail Overlay
                EventDetailOverlay(selectedEvent: $selectedEvent, width: geometry.size.width * 0.95, height: geometry.size.height * 0.85)
            }
        }
    }
}

// Custom corner radius helper
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    EventsTab()
        .modelContainer(for: Item.self, inMemory: true)
}

