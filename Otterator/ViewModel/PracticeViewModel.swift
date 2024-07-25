//
//  PracticeViewModel.swift
//  Otterator
//
//  Created by Alvin Lionel on 25/07/24.
//

import Foundation


@Observable
class PracticeViewModel {
    var timer: Timer?
    var currentWordIndex = 0
    var fullSentence: String = ""
    var highlightedWord: String = ""
    var displaySentence: String = ""
    var isPause = false
    var isPlaying = false
    var pauseDuration: Double = 0.0
    var drawingStroke = true
    
    var practiceText:[Practice] = []
    
    
    
    
    
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
    
}
