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
    @State private var events: [Event] = []
    @State private var buttonText = "Call Api"
    let api = APIService()

    let categories = ["All", "Tournament", "Game"]

//    let events = [
//        DisplayEvent(title: "Soccer", date: "Sep 30", description: "Glenn Versus Towers", location: "Tech Green", details: "Soccer finals with tons of hype and support. Bring your dorm spirit!", category: "Game"),
//        DisplayEvent(title: "Basketball Tournament", date: "Oct 6", description: "North Ave vs. Smith Hall Semi-Finals", location: "Campus Rec Center", details: "Semi-finals of the biggest basketball showdown in DormWars history.", category: "Tournament"),
//        DisplayEvent(title: "Ultimate Frisbee", date: "Oct 13", description: "Open play for all skill levels", location: "Burger Bowl Field", details: "A fun, casual game for all. No experience needed, just bring energy!", category: "Game"),
//        DisplayEvent(title: "Flag Football Finals", date: "Oct 21", description: "Championship game for all-residence hall league", location: "Bobby Dodd Stadium Practice Field", details: "Championship final for ultimate bragging rights.", category: "Game")
//    ]

    var filteredEvents: [Event] {
        events.filter { event in
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
                        HStack {
                            TextField("Search events...", text: $searchText)
                                .padding(10)
                                .background(Color(.systemGray6))
                                .cornerRadius(12)

                            Menu {
                                ForEach(categories, id: \.self) { category in
                                    Button(action: { filterCategory = category }) {
                                        Text(category)
                                        if filterCategory == category {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                            } label: {
                                Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                                    .labelStyle(.iconOnly)
                                    .font(.title2)
                            }
                        }
                        .padding(.horizontal)

                        // MARK: - Event Cards
                        ForEach(events, id: \.eventId) { event in
                            VStack(spacing: 0) {
                                // Top Bar
                                ZStack {
                                    Rectangle()
                                        .fill(
                                            LinearGradient(
                                                gradient: Gradient(colors: [Color.orange, Color.yellow]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .cornerRadius(20, corners: [.topLeft, .topRight])

                                    HStack {
                                        Text(event.eventName)
                                            .font(.title2.bold())
                                            .foregroundColor(.white)
                                            .padding(.horizontal)
                                        Spacer()
                                    }
                                }
                                .frame(height: barHeight)

                                // Card Content
                                VStack(alignment: .leading, spacing: 12) {
                                    HStack(spacing: 8) {
                                        Label {
                                            Text(event.datetime.formatted(date: .abbreviated, time: .shortened))
                                        } icon: {
                                            Image(systemName: "calendar")
                                        }
                                        .font(.subheadline)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 6)
                                        .background(Color.orange.opacity(0.15))
                                        .cornerRadius(10)

                                        Label(event.location ?? "TBD", systemImage: "mappin.and.ellipse")
                                            .font(.subheadline)
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 6)
                                            .background(Color.blue.opacity(0.15))
                                            .cornerRadius(10)
                                    }

                                    Text(event.shortDescription)
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .lineLimit(3)
                                        .padding(.top, 4)
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .topLeading)
                                .background(Color.white)
                                .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        selectedEvent = event
                                    }
                                }
                            }
                            .frame(width: cardSize)
                            .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
                        }
                    }
                    .padding(.vertical, 32)
                }
                .onAppear {
                    api.getEvents { result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let events):
                                self.events = events
                            case .failure(let error):
                                print("Error fetching events:", error)
                            }
                        }
                    }
                }

                // MARK: - Event Detail Overlay
                if let event = selectedEvent {
                    ZStack {
                        Color.black.opacity(0.4)
                            .ignoresSafeArea()
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    selectedEvent = nil
                                }
                            }

                        VStack(spacing: 0) {
                            // Top Bar
                            ZStack(alignment: .topTrailing) {
                                Rectangle()
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.orange, Color.yellow]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(height: 140)
                                    .cornerRadius(20, corners: [.topLeft, .topRight])

                                Button(action: {
                                    withAnimation(.spring()) {
                                        selectedEvent = nil
                                    }
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .padding()
                                }
                            }

                            VStack(alignment: .leading, spacing: 18) {
                                Text(event.eventName)
                                    .font(.title.bold())
                                    .padding(.bottom, 4)

                                HStack(spacing: 12) {
                                    Label {
                                        Text(event.datetime.formatted(date: .abbreviated, time: .shortened))
                                    } icon: {
                                        Image(systemName: "calendar")
                                    }
                                    .font(.subheadline)
                                    Label(event.location ?? "TBD", systemImage: "mappin.and.ellipse")
                                        .font(.subheadline)
                                }
                                .foregroundColor(.gray)

                                Divider()

                                Text(event.longDescription)
                                    .font(.body)
                                    .padding(.vertical)

                                Spacer()

                                Button(action: {
                                    // Registration logic
                                }) {
                                    Label("Register for Event", systemImage: "checkmark.circle")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.blue)
                                        .cornerRadius(16)
                                }
                            }
                            .padding()
                            Spacer()
                        }
                        .frame(width: geometry.size.width * 0.95, height: geometry.size.height * 0.85)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(radius: 14)
                        .transition(.move(edge: .bottom))
                    }
                }
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

