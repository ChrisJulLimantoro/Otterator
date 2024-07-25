//
//  DummyPauseTranscript.swift
//  Otterator
//
//  Created by Alvin Lionel on 18/07/24.
//

import Foundation
import SwiftUI

struct DummyPauseTranscript: View {
    @State private var timer: Timer?
    @State private var currentWordIndex = 0
    @State private var fullSentence: String = ""
    @State private var highlightedWord: String = ""
    @State private var displaySentence: String = ""
    @State private var isPause = false
    @State var proxy: ScrollViewProxy? = nil
    @State private var isPlaying = false
    @State private var pauseDuration: Double = 0.0
    @State private var drawingStroke = true
    
    
    var animation: Animation {
           Animation.easeOut(duration: pauseDuration)
       }
    
    var practiceText: [PauseTranscript] = [
        PauseTranscript(word: "When ", duration: 0.33, is_pause: false),
        PauseTranscript(word: "you ", duration: 0.12, is_pause: false),
        PauseTranscript(word: "pause ", duration: 0.67, is_pause: false),
        PauseTranscript(word: "\n\n", duration: 2.0, is_pause: true),
        PauseTranscript(word: "you ", duration: 0.26, is_pause: false),
        PauseTranscript(word: "give ", duration: 0.26, is_pause: false),
        PauseTranscript(word: "people ", duration: 0.34, is_pause: false),
        PauseTranscript(word: "time ", duration: 0.66, is_pause: false),
        PauseTranscript(word: "to ", duration: 0.18, is_pause: false),
        PauseTranscript(word: "process ", duration: 0.83, is_pause: false),
        PauseTranscript(word: "\nwhat ", duration: 0.15, is_pause: false),
        PauseTranscript(word: "you're ", duration: 0.35, is_pause: false),
        PauseTranscript(word: "saying ", duration: 1.23, is_pause: false),
        PauseTranscript(word: "\n\n", duration: 1.8, is_pause: true),
        PauseTranscript(word: "notice ", duration: 0.28, is_pause: false),
        PauseTranscript(word: "how ", duration: 0.10, is_pause: false),
        PauseTranscript(word: "you ", duration: 0.16, is_pause: false),
        PauseTranscript(word: "just ", duration: 0.18, is_pause: false),
        PauseTranscript(word: "processed ", duration: 0.43, is_pause: false),
        PauseTranscript(word: "\nwhat ", duration: 0.14, is_pause: false),
        PauseTranscript(word: "i ", duration: 0.22, is_pause: false),
        PauseTranscript(word: "said? ", duration: 0.38, is_pause: false),
//        PauseTranscript(word: "\n\n", duration: 2.0, is_pause: true),
//        PauseTranscript(word: "When ", duration: 0.33, is_pause: false),
//        PauseTranscript(word: "you ", duration: 0.12, is_pause: false),
//        PauseTranscript(word: "pause ", duration: 0.67, is_pause: false),
//        PauseTranscript(word: "\n\n", duration: 2.0, is_pause: true),
//        PauseTranscript(word: "you ", duration: 0.26, is_pause: false),
//        PauseTranscript(word: "give ", duration: 0.26, is_pause: false),
//        PauseTranscript(word: "people ", duration: 0.34, is_pause: false),
//        PauseTranscript(word: "time ", duration: 0.66, is_pause: false),
//        PauseTranscript(word: "to ", duration: 0.18, is_pause: false),
//        PauseTranscript(word: "process ", duration: 0.83, is_pause: false),
//        PauseTranscript(word: "\nwhat ", duration: 0.15, is_pause: false),
//        PauseTranscript(word: "you're ", duration: 0.35, is_pause: false),
//        PauseTranscript(word: "saying ", duration: 1.23, is_pause: false),
//        PauseTranscript(word: "\n\n", duration: 1.8, is_pause: true),
//        PauseTranscript(word: "notice ", duration: 0.28, is_pause: false),
//        PauseTranscript(word: "how ", duration: 0.10, is_pause: false),
//        PauseTranscript(word: "you ", duration: 0.16, is_pause: false),
//        PauseTranscript(word: "just ", duration: 0.18, is_pause: false),
//        PauseTranscript(word: "processed ", duration: 0.43, is_pause: false),
//        PauseTranscript(word: "\nwhat ", duration: 0.14, is_pause: false),
//        PauseTranscript(word: "i ", duration: 0.22, is_pause: false),
//        PauseTranscript(word: "said? ", duration: 0.38, is_pause: false),
//        PauseTranscript(word: "\n\n", duration: 2.0, is_pause: true),
//        PauseTranscript(word: "When ", duration: 0.33, is_pause: false),
//        PauseTranscript(word: "you ", duration: 0.12, is_pause: false),
//        PauseTranscript(word: "pause ", duration: 0.67, is_pause: false),
//        PauseTranscript(word: "\n\n", duration: 2.0, is_pause: true),
//        PauseTranscript(word: "you ", duration: 0.26, is_pause: false),
//        PauseTranscript(word: "give ", duration: 0.26, is_pause: false),
//        PauseTranscript(word: "people ", duration: 0.34, is_pause: false),
//        PauseTranscript(word: "time ", duration: 0.66, is_pause: false),
//        PauseTranscript(word: "to ", duration: 0.18, is_pause: false),
//        PauseTranscript(word: "process ", duration: 0.83, is_pause: false),
//        PauseTranscript(word: "\nwhat ", duration: 0.15, is_pause: false),
//        PauseTranscript(word: "you're ", duration: 0.35, is_pause: false),
//        PauseTranscript(word: "saying ", duration: 1.23, is_pause: false),
//        PauseTranscript(word: "\n\n", duration: 1.8, is_pause: true),
//        PauseTranscript(word: "notice ", duration: 0.28, is_pause: false),
//        PauseTranscript(word: "how ", duration: 0.10, is_pause: false),
//        PauseTranscript(word: "you ", duration: 0.16, is_pause: false),
//        PauseTranscript(word: "just ", duration: 0.18, is_pause: false),
//        PauseTranscript(word: "processed ", duration: 0.43, is_pause: false),
//        PauseTranscript(word: "\nwhat ", duration: 0.14, is_pause: false),
//        PauseTranscript(word: "i ", duration: 0.22, is_pause: false),
//        PauseTranscript(word: "said? ", duration: 0.38, is_pause: false),
//        PauseTranscript(word: "\n\n", duration: 2.0, is_pause: true),
//        PauseTranscript(word: "When ", duration: 0.33, is_pause: false),
//        PauseTranscript(word: "you ", duration: 0.12, is_pause: false),
//        PauseTranscript(word: "pause ", duration: 0.67, is_pause: false),
//        PauseTranscript(word: "\n\n", duration: 2.0, is_pause: true),
//        PauseTranscript(word: "you ", duration: 0.26, is_pause: false),
//        PauseTranscript(word: "give ", duration: 0.26, is_pause: false),
//        PauseTranscript(word: "people ", duration: 0.34, is_pause: false),
//        PauseTranscript(word: "time ", duration: 0.66, is_pause: false),
//        PauseTranscript(word: "to ", duration: 0.18, is_pause: false),
//        PauseTranscript(word: "process ", duration: 0.83, is_pause: false),
//        PauseTranscript(word: "\nwhat ", duration: 0.15, is_pause: false),
//        PauseTranscript(word: "you're ", duration: 0.35, is_pause: false),
//        PauseTranscript(word: "saying ", duration: 1.23, is_pause: false),
//        PauseTranscript(word: "\n\n", duration: 1.8, is_pause: true),
//        PauseTranscript(word: "notice ", duration: 0.28, is_pause: false),
//        PauseTranscript(word: "how ", duration: 0.10, is_pause: false),
//        PauseTranscript(word: "you ", duration: 0.16, is_pause: false),
//        PauseTranscript(word: "just ", duration: 0.18, is_pause: false),
//        PauseTranscript(word: "processed ", duration: 0.43, is_pause: false),
//        PauseTranscript(word: "\nwhat ", duration: 0.14, is_pause: false),
//        PauseTranscript(word: "i ", duration: 0.22, is_pause: false),
//        PauseTranscript(word: "said? ", duration: 0.38, is_pause: false),
//        PauseTranscript(word: "\n\n", duration: 2.0, is_pause: true),
//        PauseTranscript(word: "When ", duration: 0.33, is_pause: false),
//        PauseTranscript(word: "you ", duration: 0.12, is_pause: false),
//        PauseTranscript(word: "pause ", duration: 0.67, is_pause: false),
//        PauseTranscript(word: "\n\n", duration: 2.0, is_pause: true),
//        PauseTranscript(word: "you ", duration: 0.26, is_pause: false),
//        PauseTranscript(word: "give ", duration: 0.26, is_pause: false),
//        PauseTranscript(word: "people ", duration: 0.34, is_pause: false),
//        PauseTranscript(word: "time ", duration: 0.66, is_pause: false),
//        PauseTranscript(word: "to ", duration: 0.18, is_pause: false),
//        PauseTranscript(word: "process ", duration: 0.83, is_pause: false),
//        PauseTranscript(word: "\nwhat ", duration: 0.15, is_pause: false),
//        PauseTranscript(word: "you're ", duration: 0.35, is_pause: false),
//        PauseTranscript(word: "saying ", duration: 1.23, is_pause: false),
//        PauseTranscript(word: "\n\n", duration: 1.8, is_pause: true),
//        PauseTranscript(word: "notice ", duration: 0.28, is_pause: false),
//        PauseTranscript(word: "how ", duration: 0.10, is_pause: false),
//        PauseTranscript(word: "you ", duration: 0.16, is_pause: false),
//        PauseTranscript(word: "just ", duration: 0.18, is_pause: false),
//        PauseTranscript(word: "processed ", duration: 0.43, is_pause: false),
//        PauseTranscript(word: "\nwhat ", duration: 0.14, is_pause: false),
//        PauseTranscript(word: "i ", duration: 0.22, is_pause: false),
//        PauseTranscript(word: "said? ", duration: 0.38, is_pause: false),
//        PauseTranscript(word: "\n\n", duration: 2.0, is_pause: true),
//        PauseTranscript(word: "When ", duration: 0.33, is_pause: false),
//        PauseTranscript(word: "you ", duration: 0.12, is_pause: false),
//        PauseTranscript(word: "pause ", duration: 0.67, is_pause: false),
//        PauseTranscript(word: "\n\n", duration: 2.0, is_pause: true),
//        PauseTranscript(word: "you ", duration: 0.26, is_pause: false),
//        PauseTranscript(word: "give ", duration: 0.26, is_pause: false),
//        PauseTranscript(word: "people ", duration: 0.34, is_pause: false),
//        PauseTranscript(word: "time ", duration: 0.66, is_pause: false),
//        PauseTranscript(word: "to ", duration: 0.18, is_pause: false),
//        PauseTranscript(word: "process ", duration: 0.83, is_pause: false),
//        PauseTranscript(word: "\nwhat ", duration: 0.15, is_pause: false),
//        PauseTranscript(word: "you're ", duration: 0.35, is_pause: false),
//        PauseTranscript(word: "saying ", duration: 1.23, is_pause: false),
//        PauseTranscript(word: "\n\n", duration: 1.8, is_pause: true),
//        PauseTranscript(word: "notice ", duration: 0.28, is_pause: false),
//        PauseTranscript(word: "how ", duration: 0.10, is_pause: false),
//        PauseTranscript(word: "you ", duration: 0.16, is_pause: false),
//        PauseTranscript(word: "just ", duration: 0.18, is_pause: false),
//        PauseTranscript(word: "processed ", duration: 0.43, is_pause: false),
//        PauseTranscript(word: "\nwhat ", duration: 0.14, is_pause: false),
//        PauseTranscript(word: "i ", duration: 0.22, is_pause: false),
//        PauseTranscript(word: "said? ", duration: 0.38, is_pause: false),
//        PauseTranscript(word: "\n\n", duration: 2.0, is_pause: true),
//        PauseTranscript(word: "When ", duration: 0.33, is_pause: false),
//        PauseTranscript(word: "you ", duration: 0.12, is_pause: false),
//        PauseTranscript(word: "pause ", duration: 0.67, is_pause: false),
//        PauseTranscript(word: "\n\n", duration: 2.0, is_pause: true),
//        PauseTranscript(word: "you ", duration: 0.26, is_pause: false),
//        PauseTranscript(word: "give ", duration: 0.26, is_pause: false),
//        PauseTranscript(word: "people ", duration: 0.34, is_pause: false),
//        PauseTranscript(word: "time ", duration: 0.66, is_pause: false),
//        PauseTranscript(word: "to ", duration: 0.18, is_pause: false),
//        PauseTranscript(word: "process ", duration: 0.83, is_pause: false),
//        PauseTranscript(word: "\nwhat ", duration: 0.15, is_pause: false),
//        PauseTranscript(word: "you're ", duration: 0.35, is_pause: false),
//        PauseTranscript(word: "saying ", duration: 1.23, is_pause: false),
//        PauseTranscript(word: "\n\n", duration: 1.8, is_pause: true),
//        PauseTranscript(word: "notice ", duration: 0.28, is_pause: false),
//        PauseTranscript(word: "how ", duration: 0.10, is_pause: false),
//        PauseTranscript(word: "you ", duration: 0.16, is_pause: false),
//        PauseTranscript(word: "just ", duration: 0.18, is_pause: false),
//        PauseTranscript(word: "processed ", duration: 0.43, is_pause: false),
//        PauseTranscript(word: "\nwhat ", duration: 0.14, is_pause: false),
//        PauseTranscript(word: "i ", duration: 0.22, is_pause: false),
//        PauseTranscript(word: "said? ", duration: 0.38, is_pause: false),
//        PauseTranscript(word: "", duration: 2.0, is_pause: true)
    ]
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack{
                        if isPause {
                            VStack(alignment: .center){
                                Spacer()
                                ZStack{
                                    Text("Pause")
                                        .foregroundColor(.red)
                                        .font(.system(size: 36, weight: .bold))
                                        .id(0)
                                    ring()
                                        .frame(width: 300)
                                        .animation(animation, value: drawingStroke)
                                        .onAppear{
                                            drawingStroke.toggle()
                                        }
                                }
                                Spacer()
                            }
                        } else {
                            ZStack(alignment: .topLeading){
                                Text(fullSentence)
                                    .foregroundColor(.secondary)
                                    .font(.system(size: 24, weight: .regular))
                                Text(highlightedWord)
                                    .foregroundColor(.primary)
                                    .font(.system(size: 24, weight: .regular))
                                    .id(currentWordIndex)
                                //                                    LazyHStack {
                                //                                        ForEach(0..<practiceText.count, id: \.self) { index in
                                //                                            Text(practiceText[index].word)
                                //                                                .foregroundStyle(index == currentWordIndex ? .primary : .secondary)
                                //                                                .font(.system(size: 24, weight: .regular))
                                //                                                .id(index)
                                //                                                .onTapGesture {
                                //                                                    seekToWord(index: index)
                                //                                                }
                                //                                        }
                                //                                    }
                            }
                            .frame(width: 360, alignment: .leading)
                            .onAppear{
                                drawingStroke.toggle()
                            }
                        }
                    }.scrollTargetLayout()
                }
                .onAppear {
                    self.proxy = proxy
                }
                .onChange(of: highlightedWord) {
                    withAnimation(){
                        self.proxy?.scrollTo(self.currentWordIndex) //anchor: .top tapi gabisa
                    }
                }
            }
            
            Spacer()
            
            HStack {
                
                Slider(value: Binding(
                    get: { Double(currentWordIndex) / Double(practiceText.count) },
                    set: { newValue in
                        let newIndex = Int(newValue * Double(practiceText.count))
                        if newIndex != currentWordIndex {
                            seekToWord(index: newIndex)
                        }
                    }
                ), in: 0...1)
                .padding()
            }
            
            HStack {
                Button(action: {
                    if fullSentence.isEmpty {
                        startLyrics()
                    } else if isPlaying {
                        pauseLyrics()
                    } else {
                        resumeLyrics()
                    }
                    isPlaying.toggle()
                }, label: {
                    Text(isPlaying ? "Pause" : "Play")
                })
                .padding()
                .foregroundStyle(Color.white)
                .background(Color.blue)
                .clipShape(Capsule())
                
                Button(action: {
                    resetLyrics()
                    isPlaying = false
                }, label: {
                    Text("Reset")
                })
                .padding()
                .foregroundStyle(Color.white)
                .background(Color.blue)
                .clipShape(Capsule())
            }
            .padding()
            
            
        }
    }
    
    func startLyrics() {
        var newSentence = ""
        for transcript in practiceText {
            if transcript.is_pause {
                newSentence += "\n\n"
            } else {
                newSentence += transcript.word
            }
        }
        fullSentence = newSentence.trimmingCharacters(in: .whitespacesAndNewlines)
        currentWordIndex = 0
        isPause = false
        nextWord()
    }
    
    func nextWord() {
        guard currentWordIndex < practiceText.count else {
            timer?.invalidate()
            return
        }
        
        let currentWord = practiceText[currentWordIndex]
        if currentWord.is_pause {
            isPause = true
//            drawingStroke = true
            highlightedWord += "\n\n"
            pauseDuration = currentWord.duration
            timer = Timer.scheduledTimer(withTimeInterval: currentWord.duration, repeats: false) { _ in
                self.isPause = false
                self.currentWordIndex += 1
                self.nextWord()
            }
        } else {
            isPause = false
//            drawingStroke = false
            pauseDuration = 0.0
            displaySentence += currentWord.word
            highlightedWord += currentWord.word
            timer = Timer.scheduledTimer(withTimeInterval: currentWord.duration, repeats: false) { _ in
                self.currentWordIndex += 1
                self.nextWord()
            }
        }
    }
    
    func pauseLyrics() {
        timer?.invalidate()
    }
    
    func resumeLyrics() {
        nextWord()
    }
    
    func seekToWord(index: Int) {
        isPause = false
        timer?.invalidate()
        currentWordIndex = index
        highlightedWord = practiceText.prefix(index).map { $0.word }.joined(separator: "")
        if isPlaying {
            nextWord()
        }
    }
    
    func resetLyrics() {
        fullSentence = ""
        highlightedWord = ""
        displaySentence = ""
        currentWordIndex = 0
        isPause = false
        timer?.invalidate()
    }
        
    func ring() -> some View {
        Circle()
            .stroke(style: StrokeStyle(lineWidth: 16))
            .foregroundStyle(.tertiary)
            .overlay{
                Circle()
                    .trim(from: 0, to: drawingStroke ? 1 : 0)
                    .stroke(.red, style: StrokeStyle(lineWidth: 16, lineCap: .round))
            }
            .rotationEffect(.degrees(-90))
    }
    
}
