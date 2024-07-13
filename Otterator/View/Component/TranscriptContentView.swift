//
//  TranscriptContentView.swift
//  Otterator
//
//  Created by Christopher Julius on 13/07/24.
//

import SwiftUI

struct TranscriptContentView: View {
    @State var progress:CGFloat = 0
    @State var isPlay = false
    var duration:Double = 5
    var body: some View {
        CustomTranscript(progress:$progress)
            .padding(.horizontal,20)
            .padding(.vertical,8)
        Spacer()
        VStack{
            CustomProgressView(progress:$progress)
                .frame(height:20)
                .padding(.horizontal,16)
            HStack(alignment:.center){
                Text(formatSec(progress * duration))
                Spacer()
                Text(formatSec(duration))
            }.padding(.horizontal,6)
        }
        .padding(.horizontal,16)
        .padding(.vertical,12)
        HStack{
            Spacer()
            Image(systemName:"gobackward.15")
                .resizable()
                .frame(width:40,height:40)
            Spacer()
            Image(systemName: !isPlay ? "play.fill" : "pause.fill")
                .resizable()
                .frame(width:40,height:40)
                .onTapGesture{
                    withAnimation(.easeIn){
                        isPlay = !isPlay
                    }
                }
            Spacer()
            Image(systemName:"goforward.15")
                .resizable()
                .frame(width:40,height:40)
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

#Preview {
    TranscriptContentView()
}
