//
//  SportColors.swift
//  DormWars
//
//  Created by John Dsouza on 9/30/25.
//


import SwiftUI

struct SportColors {
    static let colors: [String: [Color]] = [
        "Basketball": [Color.orange.opacity(0.8), Color.orange.opacity(0.6)],
        "Soccer": [Color.green.opacity(0.8), Color.green.opacity(0.6)],
        "Flag Football": [Color.blue.opacity(0.8), Color.blue.opacity(0.6)],
        "Kickball": [Color.red.opacity(0.8), Color.red.opacity(0.6)]
    ]
    
    static func primaryColor(for sport: String) -> Color {
        colors[sport]?.first ?? Color.gray
    }
    
    static func gradient(for sport: String) -> LinearGradient {
        let gradientColors = colors[sport] ?? [Color.gray.opacity(0.6), Color.gray.opacity(0.3)]
        
        return LinearGradient(
            gradient: Gradient(colors: gradientColors),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
