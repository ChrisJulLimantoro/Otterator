//
//  GradientText.swift
//  Otterator
//
//  Created by Christopher Julius on 16/07/24.
//

import SwiftUI

struct GradientText: View {
    var text: WordTranscript
    @State var isActive: Bool = false
    var highVolume:Double = 50
    var slowPace:Double = 10
    var pitch:[Double] = [0.3,0.8]
    var time:Double
    var body: some View {
        let gradient = LinearGradient(
            gradient: Gradient(colors: [Color(hex:"#000000"), Color(hex:"#BFBFBF")]),
            startPoint: .init(x:min(max(time-text.timestamp+text.duration,0)/text.duration,0.99),y:0.5),
            endPoint: .init(x:min(max(time-text.timestamp+text.duration,0)/text.duration,1),y:0.5)
        )
        
        Text(text.avg_pace < slowPace ? text.word.uppercased() : text.word.lowercased())
            .font(.custom("Playpen Sans",size:16))
            .fontWeight(text.avg_volume >= highVolume && !text.is_pause ? .bold : .regular)
            .offset(y: ((time >= text.timestamp) && (time < text.timestamp + text.duration)) ? -3 : 0)
            .foregroundStyle(gradient)
    }
}
