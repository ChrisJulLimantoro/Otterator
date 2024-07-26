//
//  CircleButtonBackground.swift
//  Otterator
//
//  Created by Michelle Alvera Lolang on 18/07/24.
//

import SwiftUI

struct CircleButtonBackground: View {
    var bgcolor: Color
    
    var body: some View {
        Circle()
            .fill(bgcolor)
            .shadow(color: Color(hex: "#555555"), radius: 0, x: 3, y: 3)
            .frame(width: 52, height: 52)
    }
}

#Preview {
    CircleButtonBackground(bgcolor: .yellow)
}
