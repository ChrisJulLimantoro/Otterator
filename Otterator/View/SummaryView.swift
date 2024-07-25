//
//  SummaryContentView.swift
//  Otterator
//
//  Created by Michelle Alvera Lolang on 18/07/24.
//

import SwiftUI

struct SummaryView: View {
    @State private var activeTab: SegmentedTab = .summary
    var body: some View {
        ScrollView {
            VStack (spacing: -10) {
//                CustomSegmentedControl(tabs: SegmentedTab.allCases, activeTab: $activeTab, activeTint: .oBlack, inactiveTint: .oBlack.opacity(0.7)){ size in
//                    RoundedRectangle(cornerRadius: 14)
//                        .fill(.white)
//                        .frame(width: size.width, height: size.height)
//                        .padding(.horizontal, 10)
//                        .frame(maxHeight: .infinity, alignment: .bottom)
//                    
//                }
                Spacer(minLength: 20)
//                SummaryCard(bgcolor: .blue, areaName: "Pitch", areaTips: pitchTips["monotone"]!, areaTricks: pitchTricks["monotone"]!)
                SummaryCard(bgcolor: Color(hex: "#F8a90b"), areaName: "Pace", areaTips: paceTips["tooSlow"]!, areaTricks: paceTricks["tooSlow"]!)
                SummaryCard(bgcolor: Color(hex: "#d7591a"), areaName: "Pause", areaTips: pauseTips["tooMuch"]!, areaTricks: pauseTricks["tooMuch"]!)
            }
            
        }.background(Color(hex: "#fbddbc"))
    }
}

#Preview {
    SummaryView()
}
