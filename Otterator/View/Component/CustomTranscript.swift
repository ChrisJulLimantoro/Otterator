//
//  CustomTrancript.swift
//  Otterator
//
//  Created by Christopher Julius on 13/07/24.
//

import SwiftUI
import AVFoundation

struct CustomTranscript: View {
    //    @Binding var progress:CGFloat
    @Bindable var viewModel:TranscriptViewModel
    var maxChar:Int = 25
    var highVolume:Double = 50
    var slowPace:Double = 10
    var pitch:[Double] = [0.3,0.8]
    var body: some View {
        ScrollView{
            Spacer()
                .frame(height:16)
            VStack(alignment:.leading,spacing:20){
                ForEach(0..<splitText(text: viewModel.text, maxLength:maxChar).count, id:\.self){rowIndex in
                    let wordsRow = splitText(text: viewModel.text, maxLength:maxChar)[rowIndex]
//                    if !wordsRow.isEmpty {
//                        Circle()
//                            .frame(width:16,height:16)
//                            .opacity((viewModel.currentTime > wordsRow.first!.first!.timestamp && viewModel.currentTime < (wordsRow.last!.last!.timestamp + wordsRow.last!.last!.duration)) ? 1 : 0)
//                            
//                    }
                    HStack{
                        ForEach(wordsRow.indices, id:\.self){colIndex in
                            let group = wordsRow[colIndex]
                            let random = Int.random(in: 0..<3 )
                            ZStack(alignment:.leading){
                                HStack{
                                    ForEach(group.indices, id:\.self){index in
                                        let wordCol = group[index]
                                        GradientText(
                                            text: wordCol,
                                            time: viewModel.currentTime
                                        )
                                        .onTapGesture {
                                            withAnimation(.easeInOut){
                                                viewModel.changeLocation(wordCol.timestamp)
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(2)
                            .background{
                                RoundedRectangle(cornerRadius:5)
                                    .foregroundColor(random == 0 ? Color(hex:"#00A3FF").opacity(0.3) : random == 1 ? Color(hex:"#FF8D23").opacity(0.3) : Color(hex:"#FFFFFF").opacity(0.3))
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
//            let wordType = word.is_pause ? 1 : word.avg_pitch < pitch[0] ? 0 : word.avg_pitch < pitch[1] ? 1 : 2
            let wordType = word.is_pause ? 1 : Int.random(in: 0..<3)
            
            // for changing the lines logic
            if currentLength + wordLength > maxLength {
                groups.append(currentGroups)
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

//#Preview {
////    @State var progress:CGFloat = 0
//    return CustomTranscript()
//}
