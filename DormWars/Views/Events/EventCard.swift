//
//  EventCard.swift
//  DormWars
//
//  Created by Drew Mendelow on 9/30/25.
//
import SwiftUI
import SwiftData

struct EventCard: View {
    let event: Event
    @Binding var selectedEvent: Event?
    let barHeight: CGFloat
    let cardSize: CGFloat
    
    var body: some View {
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
