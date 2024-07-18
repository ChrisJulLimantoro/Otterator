//
//  CardBackground.swift
//  Otterator
//
//  Created by Michelle Alvera Lolang on 17/07/24.
//

import SwiftUI

struct CardBackground: View {
    var bgcolor: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 14.0)
            .fill(bgcolor)
            .shadow(color: Color(hex: "#555555"), radius: 0, x: 4, y: 4)
//            .frame(width: 341)
    }
}

#Preview {
    CardBackground(bgcolor: .blue)
}
