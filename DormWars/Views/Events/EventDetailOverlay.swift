//
//  EventDetailOverlay.swift
//  DormWars
//
//  Created by Drew Mendelow on 9/30/25.
//
import SwiftUI

struct EventDetailOverlay: View {
    @Binding var selectedEvent: Event?
    let width: CGFloat
    let height: CGFloat
    
    
    
    var body: some View {
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
                            .fill(SportColors.gradient(for: event.sport.sportName))
                            .frame(height: 90)
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
                            // Register stuff
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
                .frame(width: width, height: height)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 14)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 5)
                )
                .transition(.move(edge: .bottom))
            }
        }
    }
}
