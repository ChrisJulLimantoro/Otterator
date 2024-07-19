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
    
    var practiceText: [PauseTranscript] = [
        PauseTranscript(word: "When", duration: 0.33, is_pause: false),
        PauseTranscript(word: "you", duration: 0.12, is_pause: false),
        PauseTranscript(word: "pause", duration: 0.67, is_pause: false),
        PauseTranscript(word: "", duration: 2.0, is_pause: true),
        PauseTranscript(word: "you", duration: 0.26, is_pause: false),
        PauseTranscript(word: "give", duration: 0.26, is_pause: false),
        PauseTranscript(word: "people", duration: 0.34, is_pause: false),
        PauseTranscript(word: "time", duration: 0.66, is_pause: false),
        PauseTranscript(word: "to", duration: 0.18, is_pause: false),
        PauseTranscript(word: "process", duration: 0.83, is_pause: false),
        PauseTranscript(word: "\nwhat", duration: 0.15, is_pause: false),
        PauseTranscript(word: "you're", duration: 0.35, is_pause: false),
        PauseTranscript(word: "saying", duration: 1.23, is_pause: false),
        PauseTranscript(word: "", duration: 1.8, is_pause: true),
        PauseTranscript(word: "notice", duration: 0.28, is_pause: false),
        PauseTranscript(word: "how ", duration: 0.10, is_pause: false),
        PauseTranscript(word: "you", duration: 0.16, is_pause: false),
        PauseTranscript(word: "just", duration: 0.18, is_pause: false),
        PauseTranscript(word: "processed", duration: 0.43, is_pause: false),
        PauseTranscript(word: "\nwhat", duration: 0.14, is_pause: false),
        PauseTranscript(word: "i", duration: 0.22, is_pause: false),
        PauseTranscript(word: "said?", duration: 0.38, is_pause: false),
//        PauseTranscript(word: "", duration: 2.0, is_pause: true)
    ]
    
    var body: some View {
        VStack {
            ScrollView{
                if isPause {
                    Spacer()
                    Text("Pause")
                        .foregroundColor(.red)
                        .font(.system(size: 24, weight: .bold))
                    Spacer()
                } else {
                    ZStack(alignment: .topLeading){
                        Text(fullSentence)
                            .foregroundColor(.gray)
                            .font(.system(size: 24, weight: .regular))
                        Text(highlightedWord)
                            .foregroundColor(.black)
                            .font(.system(size: 24, weight: .regular))
                    }
                    .frame(width: 360, alignment: .leading)
                }
            }
            Spacer()
            
            HStack {
                Button(action: {
                    if fullSentence.isEmpty {
                        startLyrics()
                    }
                }, label: {
                    Text("Start")
                })
                .disabled(!fullSentence.isEmpty)
                .padding()
                .foregroundStyle(Color.white)
                .background(Color.blue)
                .clipShape(Capsule())
                
                Button(action: {
                    resetLyrics()
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
                newSentence += transcript.word + " "
            }
        }
        fullSentence = newSentence.trimmingCharacters(in: .whitespacesAndNewlines)
        currentWordIndex = 0
        isPause = false
        nextWord()
    }
    
    func nextWord() {
        if currentWordIndex < practiceText.count {
            let currentWord = practiceText[currentWordIndex]
            if currentWord.is_pause {
                isPause = true
                highlightedWord += "\n\n"
                Timer.scheduledTimer(withTimeInterval: currentWord.duration, repeats: false) { _ in
                    self.isPause = false
                    self.currentWordIndex += 1
                    self.nextWord()
                }
            } else {
                isPause = false
                displaySentence +=  currentWord.word + " "
                highlightedWord += currentWord.word + " "
                Timer.scheduledTimer(withTimeInterval: currentWord.duration, repeats: false) { _ in
                    self.currentWordIndex += 1
                    self.nextWord()
                }
            }
        } else {
            timer?.invalidate()
        }
    }
    
    func resetLyrics() {
        fullSentence = ""
        highlightedWord = ""
        currentWordIndex = 0
        isPause = false
        timer?.invalidate()
    }
}
