//
//  EventSearchFilterBar.swift
//  DormWars
//
//  Created by Drew Mendelow on 9/30/25.
//
import SwiftUI

struct EventSearchFilterBar: View {
    @Binding var searchText: String
    @Binding var filterCategory: String
    let categories: [String]
    
    var body: some View {
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
    }
}
