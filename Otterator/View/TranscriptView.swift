//
//  TranscriptView.swift
//  Otterator
//
//  Created by Christopher Julius on 12/07/24.
//

import SwiftUI
import AVFAudio

struct TranscriptView: View {
    @State private var activeTab: SegmentedTab = .transcript
    @State var isPlay = false
    @State var progress:CGFloat = 0
    @State var isPresented:[Bool] = [false,false,false]
    @State var edit:Bool = false
    
    @Bindable var viewModel: TranscriptViewModel
    @State var word:WordTranscript = WordTranscript()
    
    var tabs = ["Vocal","Practice","Summary"]
    var body: some View {
            VStack{
                CustomSegmentedControl(tabs: SegmentedTab.allCases, activeTab: $activeTab, activeTint: .oBlack, inactiveTint: .oBlack.opacity(0.7)){ size in
                    RoundedRectangle(cornerRadius: 14)
                        .fill(.white)
                        .frame(width: size.width, height: size.height)
                        .padding(.horizontal, 10)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                }
                if activeTab == .summary {
                    SummaryView(viewModel: viewModel)
                } else {
                    TranscriptContentView(viewModel: viewModel)
                }
            }
            .navigationTitle(viewModel.record.title)
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.oBackground)
            .sheet(isPresented:$isPresented[2]){
                InformationModalView()
                    .presentationDetents([.large])
                    .presentationBackgroundInteraction(.disabled)
                    .presentationBackground(.ultraThickMaterial)
            }
        }
}
