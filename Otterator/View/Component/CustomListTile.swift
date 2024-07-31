//
//  CustomListTile.swift
//  Otterator
//
//  Created by Christopher Julius on 26/07/24.
//

import SwiftUI

struct CustomListTile: View {
    var item: Record
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        ZStack {
            NavigationLink(destination: ChoiceView(item: item)) { EmptyView()
            }.opacity(0.0)
            VStack{
                HStack{
                    Text(item.title)
                        .font(.playpenSans(.semiBold, 20, .title3))
                    Spacer()
                }
                HStack{
                    Text(item.datetime.formatted(date: .long, time: .omitted))
                        .font(.playpenSans(.regular, 14, .title3))
                    Spacer()
                    Text("\(formatTime(item.duration))")
                        .font(.playpenSans(.regular, 14, .title3))
                }
                .foregroundStyle(.secondary)
            }
        }
        .listRowBackground(Color.oBackground)
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(CardBackground(bgcolor: .white))
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                deleteItems()
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
        .listRowSeparator(.hidden)
    }
    
    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func deleteItems() {
        withAnimation {
            modelContext.delete(item)
        }
    }
}
