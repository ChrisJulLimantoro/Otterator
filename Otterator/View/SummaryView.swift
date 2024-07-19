//
//  SummaryContentView.swift
//  Otterator
//
//  Created by Michelle Alvera Lolang on 18/07/24.
//

import SwiftUI

struct SummaryView: View {
    var body: some View {
        ScrollView {
            VStack (spacing: -10) {
                SummaryCard(bgcolor: .blue, areaName: "Pitch", areaValue: "200 Hz", areaTips: pitchTips["monotone"]!, areaTricks: pitchTricks["monotone"]!)
                SummaryCard(bgcolor: Color(hex: "#F8a90b"), areaName: "Pace", areaValue: "108 wpm", areaTips: paceTips["tooSlow"]!, areaTricks: paceTricks["tooSlow"]!)
                SummaryCard(bgcolor: Color(hex: "#d7591a"), areaName: "Projection", areaValue: "95 dB", areaTips: projectionTips["tooLoud"]!, areaTricks: projectionTricks["tooLoud"]!)
                SummaryCard(bgcolor: Color(hex: "#d7591a"), areaName: "Pause", areaValue: "1.75 s", areaTips: pauseTips["tooMuch"]!, areaTricks: pauseTricks["tooMuch"]!)
            }
            
        }.background(Color(hex: "#CCE5FF"))
    }
}

#Preview {
    SummaryView()
}
