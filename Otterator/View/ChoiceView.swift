//
//  ChoiceView.swift
//  Otterator
//
//  Created by Michelle Alvera Lolang on 25/07/24.
//

import SwiftUI

struct ChoiceView: View {
    @State var viewModel:TranscriptViewModel = TranscriptViewModel(Record(id: UUID(), title: "adsad", audio_file: "asdasd", datetime: Date(), duration: 0, transcript: [], avg_pitch: 0, avg_volume: 0, avg_pause: 0, avg_pace: 0))
    var item: Record
    
    @State var isEvaluateShowing: Bool = false
    
    var body: some View {
            VStack(alignment: .center, spacing: 20){
                Text("Tap to Edit")
                    .playpenSans(.light, 14, .caption)
                    .foregroundStyle(.black)
                    .padding(.bottom,-15)
                EditContentView(viewModel: viewModel)
                    .padding(.horizontal,24)
                    .padding(.bottom,16)
                
                Button {
                    viewModel.initAudio()
                    isEvaluateShowing = true
                } label: {
                    HStack{
                        Image(systemName: "doc.text.magnifyingglass")
                        Text("Evaluate")
                            .font(.playpenSans(.semiBold, 20, .title3))
                    }
                    .frame(width: 340, height: 70)
                    .foregroundStyle(.white)
                    .background(CardBackground(bgcolor: Color.accentColor))
                }
                .navigationDestination(isPresented: $isEvaluateShowing) {
                    TranscriptView(viewModel: viewModel)
                }
                
                NavigationLink(destination: PracticeView(viewModel: PracticeViewModel(item))) {
                    HStack{
                        Image(systemName: "music.mic")
                        Text("Start Practice")
                            .font(.playpenSans(.semiBold, 20, .title3))
                    }
                    .frame(width: 340, height: 70)
                    .foregroundStyle(Color.accentColor)
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
        .onAppear{
            viewModel = TranscriptViewModel(item)
        }
    }
}
