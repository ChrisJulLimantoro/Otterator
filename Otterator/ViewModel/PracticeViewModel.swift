//
//  PracticeViewModel.swift
//  Otterator
//
//  Created by Alvin Lionel on 25/07/24.
//

import Foundation


@Observable
class PracticeViewModel {
    var record: Record
    var timer: Timer?
    var currentWordIndex = 0
    var fullSentence: String = ""
    var highlightedWord: String = ""
    var displaySentence: String = ""
    var isPause = false
    var isPlaying = false
    var pauseDuration: Double = 0.0
    var drawingStroke = true
    var isLoading = false
    
    init(_ t_record:Record){
        self.record = t_record
    }
    
    
    func startLyrics() {
        var newSentence = ""
        for transcript in record.practice!.sorted(by:{$0.timestamp < $1.timestamp}) {
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
        guard currentWordIndex < record.practice!.count else {
            timer?.invalidate()
            return
        }
        
        let currentWord = record.practice!.sorted(by: {$0.timestamp < $1.timestamp})[currentWordIndex]
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
        highlightedWord = record.practice!.prefix(index).map { $0.word }.joined(separator: "")
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
    
    func getPractice(){
        isLoading = true
        if self.record.practiceVersion == self.record.version && self.record.version > 0 {
            isLoading = false
        } else {
            let apiUrl:URL = URL(string:"https://climantoro.pythonanywhere.com/api")!
            let encoder = JSONEncoder()
            var request:URLRequest = URLRequest(url:apiUrl)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            
            let text = self.record.transcript!.sorted(by: {$0.timestamp < $1.timestamp}).filter{ !$0.is_pause }.map{
                $0.corrected_word
            }.reduce(""){ $0 + " " + $1 }.trimmingCharacters(in: .whitespaces)
            let message = Message(phrase:text)
            
            request.httpBody = try! encoder.encode(message)
            
            let task = URLSession.shared.dataTask(with:request){ data, response, error in
                
                let decoder = JSONDecoder()
                
                if let data = data{
                    do {
                        let json = try decoder.decode([JsonPractice].self,from:data)
                        let practices = json.map{
                            Practice(word:$0.text,duration:$0.duration,is_pause:$0.is_pause,timestamp: $0.timestamp)
                        }.sorted(by: {$0.timestamp < $1.timestamp})
                        
                        DispatchQueue.main.async{
                            self.record.practice = practices
                            self.isLoading = false
                            self.record.practiceVersion = self.record.version
                            if self.record.version == 0 {
                                self.record.version = 1
                                self.record.practiceVersion = 1
                            }
                        }
                    } catch  {
                        print(data)
                        print(error.localizedDescription)
                    }
                }
                
            }
            task.resume()
        }
    }
}
