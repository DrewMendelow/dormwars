//
//  EventsTab.swift
//  DormWars
//
//  Created by John Dsouza on 9/26/25.
//

import SwiftUI
import SwiftData

struct Event: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let description: String
    let location: String
    let details: String
    let category: String
}

struct EventsTab: View {
    @State private var searchText: String = ""
    @State private var filterCategory: String = "All"
    @State private var selectedEvent: Event?

    let categories = ["All", "Tournament", "Game"]

    let events = [
        Event(title: "Soccer", date: "Sep 30", description: "Glenn Versus Towers", location: "Tech Green", details: "Soccer finals with tons of hype and support. Bring your dorm spirit!", category: "Game"),
        Event(title: "Basketball Tournament", date: "Oct 6", description: "North Ave vs. Smith Hall Semi-Finals", location: "Campus Rec Center", details: "Semi-finals of the biggest basketball showdown in DormWars history.", category: "Tournament"),
        Event(title: "Ultimate Frisbee", date: "Oct 13", description: "Open play for all skill levels", location: "Burger Bowl Field", details: "A fun, casual game for all. No experience needed, just bring energy!", category: "Game"),
        Event(title: "Flag Football Finals", date: "Oct 21", description: "Championship game for all-residence hall league", location: "Bobby Dodd Stadium Practice Field", details: "Championship final for ultimate bragging rights.", category: "Game")
    ]

    var filteredEvents: [Event] {
        events.filter { event in
            (filterCategory == "All" || event.category == filterCategory) &&
            (searchText.isEmpty || event.title.localizedCaseInsensitiveContains(searchText))
        }
    }

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    LinearGradient(
                        gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.1)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()
                    let cardSize = geometry.size.width * 0.9
                    let barHeight = cardSize * 0.20
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 20) {
                            
                            // MARK: - Page Header
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Events")
                                    .font(.largeTitle.bold())
                                Text("Check out all upcoming competitions and activities")
                                    .font(.subheadline.bold())
                                    .foregroundColor(.gray)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                            
                            // MARK: - Search + Filter
                            HStack {
                                TextField("Search events...", text: $searchText)
                                    .padding(10)
                                    .background(Color(.gray.opacity(0.1)))
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
                            ForEach(filteredEvents) { event in
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
                                            Text(event.title)
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
                                            Label(event.date, systemImage: "calendar")
                                                .font(.subheadline)
                                                .padding(.horizontal, 10)
                                                .padding(.vertical, 6)
                                                .background(Color.orange.opacity(0.15))
                                                .cornerRadius(10)
                                            
                                            Label(event.location, systemImage: "mappin.and.ellipse")
                                                .font(.subheadline)
                                                .padding(.horizontal, 10)
                                                .padding(.vertical, 6)
                                                .background(Color.blue.opacity(0.15))
                                                .cornerRadius(10)
                                        }
                                        
                                        Text(event.description)
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
                                        .frame(height: 100)
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
                                    Text(event.title)
                                        .font(.title.bold())
                                        .padding(.bottom, 4)
                                    
                                    HStack(spacing: 12) {
                                        Label(event.date, systemImage: "calendar")
                                            .font(.subheadline)
                                        Label(event.location, systemImage: "mappin.and.ellipse")
                                            .font(.subheadline)
                                    }
                                    .foregroundColor(.gray)
                                    
                                    Divider()
                                    
                                    Text(event.details)
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
