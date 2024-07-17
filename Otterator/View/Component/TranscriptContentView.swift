//
//  TranscriptContentView.swift
//  Otterator
//
//  Created by Christopher Julius on 13/07/24.
//

import SwiftUI
import AVFoundation

struct TranscriptContentView: View {
    @State var progress:CGFloat = 0
    @State var isPlay = false
    @Bindable var viewModel: TranscriptViewModel
    
    var body: some View {
        CustomTranscript(viewModel:viewModel)
            .padding(.horizontal,20)
            .padding(.vertical,8)
        Spacer()
        VStack{
            CustomProgressView(viewModel:viewModel)
                .frame(height:20)
                .padding(.horizontal,16)
            HStack(alignment:.center){
                Text(formatSec(viewModel.currentTime))
                Spacer()
                Text(formatSec(viewModel.audio.duration))
            }.padding(.horizontal,6)
        }
        .padding(.horizontal,16)
        .padding(.vertical,12)
        HStack{
            Spacer()
            Image(systemName:"gobackward.15")
                .resizable()
                .frame(width:40,height:40)
                .onTapGesture{
                    withAnimation(.easeInOut){
                        viewModel.reduceSeconds(15)
                    }
                }
            Spacer()
            Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
                .resizable()
                .frame(width:40,height:40)
                .onTapGesture{
                    viewModel.audioToogle()
                }
            Spacer()
            Image(systemName:"goforward.15")
                .resizable()
                .frame(width:40,height:40)
                .onTapGesture{
                    withAnimation(.easeInOut){
                        viewModel.addSeconds(15)
                    }
                }
            Spacer()
        }
    }
    func formatSec(_ second:Double) -> String
    {
        let totalSeconds = Int(floor(second))
        let minutes = totalSeconds / 60
        let remainingSeconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
}

//#Preview {
//    TranscriptContentView()
//}
