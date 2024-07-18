//
//  Recordings.swift
//  Otterator
//
//  Created by Bayu Aditya Triwibowo on 12/07/24.
//

import SwiftUI

struct Recordings: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    VStack{
                        HStack{
                            Text("Latihan Presentasi MC3")
                                .foregroundStyle(.primary)
                            Spacer()
                        }
                        HStack{
                            Text("5 Jul 2024")
                            Spacer()
                            Text("12.20")
                        }.foregroundStyle(.secondary)
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            // delete
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
                .listStyle(.inset)
                Spacer()
                Button{
                    //Record Button
                } label: {
                    Circle()
                        .stroke(style: /*@START_MENU_TOKEN@*/StrokeStyle()/*@END_MENU_TOKEN@*/)
                        .overlay(content: Circle())
                }
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray6))
            }.navigationTitle("All Recordings")
                .toolbar{
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        EditButton()
                    }
                }
                .searchable(text: $searchText)
        }
    }
}

#Preview {
    Recordings()
}
