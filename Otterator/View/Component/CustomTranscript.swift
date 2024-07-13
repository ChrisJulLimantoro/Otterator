//
//  CustomTrancript.swift
//  Otterator
//
//  Created by Christopher Julius on 13/07/24.
//

import SwiftUI

struct CustomTranscript: View {
    @Binding var progress:CGFloat
    var duration:Double = 5
    var text:[WordTranscript] = [
        WordTranscript(word: "hai,", timestamp: 0, duration: 0.3, voice_analysis: VoiceAnalyst(pitch: [0.0,0.4,0.1,0.3], volume: [50,0.1,0.2,4.2]), avg_pitch: 0.1, avg_volume: 25, avg_pace : 5, corrected_word: "", is_pause: false),
        WordTranscript(word: "//", timestamp: 0.3, duration: 0.2, voice_analysis: VoiceAnalyst(pitch: [0.0,0.4,0.1,0.3], volume: [50,0.1,0.2,4.2]), avg_pitch: 0.2, avg_volume: 20,avg_pace : 12, corrected_word: "", is_pause: true),
        WordTranscript(word: "how", timestamp: 0.5, duration: 0.2, voice_analysis: VoiceAnalyst(pitch: [0.0,0.4,0.1,0.3], volume: [50,0.1,0.2,4.2]), avg_pitch: 0.8, avg_volume: 12,avg_pace : 3, corrected_word: "", is_pause: false),
        WordTranscript(word: "are", timestamp: 0.7, duration: 0.3, voice_analysis: VoiceAnalyst(pitch: [0.0,0.4,0.1,0.3], volume: [50,0.1,0.2,4.2]), avg_pitch: 0.5, avg_volume: 20,avg_pace : 15, corrected_word: "", is_pause: false),
        WordTranscript(word: "you?", timestamp: 1, duration: 0.3, voice_analysis: VoiceAnalyst(pitch: [0.0,0.4,0.1,0.3], volume: [50,0.1,0.2,4.2]), avg_pitch: 0.5, avg_volume: 65,avg_pace : 16, corrected_word: "", is_pause: false),
        WordTranscript(word: "//", timestamp: 1.3, duration: 0.5, voice_analysis: VoiceAnalyst(pitch: [0.0,0.4,0.1,0.3], volume: [50,0.1,0.2,4.2]), avg_pitch: 0.1, avg_volume: 45,avg_pace : 2, corrected_word: "", is_pause: true),
        WordTranscript(word: "i'm", timestamp: 1.8, duration: 0.3, voice_analysis: VoiceAnalyst(pitch: [0.0,0.4,0.1,0.3], volume: [50,0.1,0.2,4.2]), avg_pitch: 0.85, avg_volume: 20,avg_pace : 14, corrected_word: "", is_pause: false),
        WordTranscript(word: "fine", timestamp: 2.1, duration: 0.2, voice_analysis: VoiceAnalyst(pitch: [0.0,0.4,0.1,0.3], volume: [50,0.1,0.2,4.2]), avg_pitch: 0.2, avg_volume: 20,avg_pace : 11, corrected_word: "", is_pause: false),
        WordTranscript(word: "too.", timestamp: 2.3, duration: 0.3, voice_analysis: VoiceAnalyst(pitch: [0.0,0.4,0.1,0.3], volume: [50,0.1,0.2,4.2]), avg_pitch: 0.2, avg_volume: 55,avg_pace : 10, corrected_word: "", is_pause: false)
    ]
    var maxChar:Int = 30
    var highVolume:Double = 50
    var slowPace:Double = 10
    var pitch:[Double] = [0.3,0.8]
    var body: some View {
        ScrollView{
            VStack(alignment:.leading,spacing:20){
                ForEach(0..<splitText(text: text, maxLength:   maxChar).count, id:\.self){rowIndex in
                    let wordsRow = splitText(text: text, maxLength:   maxChar)[rowIndex]
                    HStack{
                        ForEach(wordsRow.indices, id:\.self){colIndex in
                            let group = wordsRow[colIndex]
                            ZStack(alignment:.leading){
                                HStack{
                                    ForEach(group.indices, id:\.self){index in
                                        let wordCol = group[index]
                                        Text(wordCol.word)
                                            .font(.custom("Playpen Sans",size:16))
                                            .fontWeight(wordCol.avg_volume >= highVolume && !wordCol.is_pause ? .bold : .regular)
                                            .textCase(wordCol.avg_pace < slowPace ? .uppercase : .lowercase)
                                            .onTapGesture {
                                                withAnimation(.easeIn){
                                                    progress = wordCol.timestamp / duration
                                                }
                                            }
                                            .onLongPressGesture(minimumDuration:0.8){
                                                // open modal
                                            }
                                    }
                                }
                            }
                            .padding(2)
                            .background{
                                RoundedRectangle(cornerRadius:5)
                                    .foregroundColor(group[0].avg_pitch < pitch[0] && !group[0].is_pause ? Color(hex:"#00A3FF").opacity(0.3) : group[0].avg_pitch > pitch[1] && !group[0].is_pause ? Color(hex:"#FF8D23").opacity(0.3) : Color(hex:"#FFFFFF").opacity(0.3))
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
    }
    
    func splitText(text:[WordTranscript],maxLength: Int) ->
    [[[WordTranscript]]] {
        var lines:[[[WordTranscript]]] = [] // for lines
        var groups:[[WordTranscript]] = [] // grouping by background
        var currentGroups:[WordTranscript] = [] // tracking current
        var currentLength = 0
        var currentType = 0
        
        for word in text{
            let wordLength = word.word.count
            let wordType = word.is_pause ? 1 : word.avg_pitch < pitch[0] ? 0 : word.avg_pitch < pitch[1] ? 1 : 2
            
            // for changing the lines logic
            if currentLength + wordLength > maxLength {
                lines.append(groups)
                groups = []
                currentGroups = [word]
                currentType = wordType
                currentLength = word.word.count
            } else if ["?", ".", "!"].map({word.word.contains($0)}).reduce(false, {$0 || $1}){
                if currentType != wordType {
                    groups.append(currentGroups)
                    currentGroups = [word]
                    currentType = wordType
                } else {
                    currentGroups.append(word)
                }
                groups.append(currentGroups)
                lines.append(groups)
                lines.append([])
                groups = []
                currentGroups = []
                currentLength = 0
            } else {
                if word.is_pause && currentLength == 0 && lines.count > 0 {
                    if lines[lines.count - 1].isEmpty {
                        lines[lines.count - 2].append([word])
                    }else{
                        lines[lines.count - 1].append([word])
                    }
                } else {
                    if wordType != currentType && currentLength > 0{
                        groups.append(currentGroups)
                        currentGroups = [word]
                    } else {
                        currentGroups.append(word)
                    }
                    currentLength += wordLength
                }
            }
            currentType = wordType
        }
        
        if !currentGroups.isEmpty {
            groups.append(currentGroups)
            lines.append(groups)
        }
        return lines
    }
}

#Preview {
    @State var progress:CGFloat = 0
    return CustomTranscript(progress: $progress,duration: 5)
}
