//
//  ChoiceView.swift
//  Otterator
//
//  Created by Michelle Alvera Lolang on 25/07/24.
//

import SwiftUI

struct ChoiceView: View {
    var item: Record
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center, spacing: 20){
                NavigationLink(destination: PausePracticeView()) {
                    HStack{
                        Image(systemName: "doc.text.magnifyingglass")
                        Text("Start Practice")
                            .font(.playpenSans(.semiBold, 20, .title3))
                    }
                    .frame(width: 340, height: 70)
                    .foregroundStyle(.white)
                    .background(CardBackground(bgcolor: .accent))
                }
                NavigationLink(destination: TranscriptView(viewModel: TranscriptViewModel(item))) {
                    HStack{
                        Image(systemName: "music.mic")
                        Text("Evaluate")
                            .font(.playpenSans(.semiBold, 20, .title3))
                    }
                    .frame(width: 340, height: 70)
                    .foregroundStyle(.accent)
                    .background(CardBackground(bgcolor: .white))
                }
            }
            .containerRelativeFrame(
                [.horizontal, .vertical],
                alignment: .center
            )
            .background(Color.oBackground)
            .navigationTitle(item.title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ChoiceView(item: Record(id: UUID(), title: "adsad", audio_file: "asdasd", datetime: Date(), duration: 0, transcript: [], avg_pitch: 0, avg_volume: 0, avg_pause: 0, avg_pace: 0))
}
