//
//  EditContentView.swift
//  Otterator
//
//  Created by Christopher Julius on 18/07/24.
//

import SwiftUI

struct EditContentView: View {
    @Bindable var viewModel:TranscriptViewModel
    @Binding var word:WordTranscript
    @Binding var edit:Bool
    var body: some View {
        ScrollView{
            Spacer()
                .frame(height: 16)
            VStack(alignment:.leading,spacing:20){
                ForEach(0..<splitText(text: viewModel.text, maxLength:30).count, id:\.self){rowIndex in
                    let wordsRow = splitText(text: viewModel.text, maxLength:30)[rowIndex]
                    HStack{
                        ForEach(wordsRow.indices, id:\.self){colIndex in
                            let wordCol = wordsRow[colIndex]
                            ZStack{
                                Text(wordCol.word)
                                    .font(.custom("Playpen Sans",size:16))
                                    .strikethrough(wordCol.corrected_word != wordCol.word,color: .red)
                                if wordCol.corrected_word != wordCol.word {
                                    Text(wordCol.corrected_word)
                                        .font(.custom("Playpen Sans",size:14))
                                        .foregroundStyle(.red)
                                        .offset(x:3,y:-14)
                                }
                            }
                            .onTapGesture {
                                word = wordCol
                                edit = !edit
                                print(viewModel.text.map{$0.corrected_word})
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
        .padding(.horizontal,20)
        .padding(.vertical,8)
        Spacer()
        Text("Start Practice")
    }
    func splitText(text:[WordTranscript],maxLength: Int) ->
    [[WordTranscript]] {
        var lines:[[WordTranscript]] = [] // for lines
        var currentLine:[WordTranscript] = [] // tracking current
        var currentLength = 0
        
        for word in text{
            let wordLength = word.word.count
            if word.is_pause {
                continue
            }
            // for changing the lines logic
            if currentLength + wordLength > maxLength {
                lines.append(currentLine)
                currentLine = [word]
                currentLength = word.word.count
            } else if ["?", ".", "!"].map({word.word.contains($0)}).reduce(false, {$0 || $1}){
                currentLine.append(word)
                lines.append(currentLine)
                lines.append([])
                currentLine = []
                currentLength = 0
            } else {
                if word.is_pause && currentLength == 0 && lines.count > 0 {
                    if lines[lines.count - 1].isEmpty {
                        lines[lines.count - 2].append(word)
                    }else{
                        lines[lines.count - 1].append(word)
                    }
                } else {
                    currentLine.append(word)
                    currentLength += wordLength
                }
            }
        }
        
        if !currentLine.isEmpty {
            lines.append(currentLine)
        }
        return lines
    }
}

#Preview {
    @State var viewModel = TranscriptViewModel("hello")
    @State var word:WordTranscript = WordTranscript()
    @State var edit:Bool = false
    return EditContentView(viewModel: viewModel,word: $word,edit: $edit)
}
