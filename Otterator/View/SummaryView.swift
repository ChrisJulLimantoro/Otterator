//
//  SummaryContentView.swift
//  Otterator
//
//  Created by Michelle Alvera Lolang on 18/07/24.
//

import SwiftUI

struct SummaryView: View {
    @State private var activeTab: SegmentedTab = .summary
    @Bindable var viewModel: TranscriptViewModel
    var body: some View {
        ScrollView {
            VStack (spacing: -10) {
                Spacer(minLength: 20)
                let pace = viewModel.record.avg_pace < 120 ?  "too Slow" : viewModel.record.avg_pace > 150 ? "too Fast" : "no Pause"
                SummaryCard(bgcolor: Color(hex: "#F8a90b"), areaName: "Pace",areaResult: pace, areaTips: paceTips[pace]!, areaTricks: paceTricks[pace]!)
                SummaryCard(bgcolor: Color(hex: "#d7591a"), areaName: "Pause",areaResult: viewModel.pauseCategory, areaTips: pauseTips[viewModel.pauseCategory]!, areaTricks: pauseTricks[viewModel.pauseCategory]!)
            }
        }.background(Color(hex: "#fbddbc"))
            .onAppear{
                print("pace \(viewModel.record.avg_pace)")
                print("pause \(viewModel.record.avg_pause)")
            }
    }
}

//#Preview {
//    SummaryView()
//}
