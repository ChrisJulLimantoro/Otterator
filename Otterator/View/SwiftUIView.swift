//
//  SwiftUIView.swift
//  Otterator
//
//  Created by Bayu Aditya Triwibowo on 16/07/24.
//

import SwiftUI

struct SwiftUIView: View {
    var record: Record
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                ForEach(record.transcript!) { item in
                    Text(item.word)
                        .padding()
                        .background(item.is_pause ? Color.red : Color.blue)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
    }
}

