//
//  TranscriptViewModel.swift
//  Otterator
//
//  Created by Christopher Julius on 15/07/24.
//

import Foundation
import AVFoundation
import SwiftUI

@Observable
class TranscriptViewModel {
    
    var audio:AVAudioPlayer?
    
    var text:[WordTranscript] = []
    
    var isPlaying: Bool = false
    var currentTime:Double = 0
    var timer:Timer?
    
    init(_ record: Record){
        do{
            audio = try AVAudioPlayer(contentsOf: URL(string: record.audio_file)!)
            text = record.transcript!.sorted(by: {$0.timestamp < $1.timestamp})
            print(text.map{"word: \($0.word), timestamp: \($0.timestamp), duration: \($0.duration)\n"})
        } catch {
            print(error)
        }
        
    }
    
    func audioToogle(){
        if isPlaying {
            audioPause()
        } else {
            audioPlay()
        }
    }
    
    func audioPlay(){
        let playSession = AVAudioSession.sharedInstance()
        
        do {
            try playSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {
            print("Failed")
        }
        
        audio?.prepareToPlay()
        audio!.play()
        isPlaying = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { _ in
            if self.currentTime < self.audio!.duration{
                withAnimation(.bouncy){
                    self.currentTime += 0.01
                }
            } else {
                self.timer?.invalidate()
                self.isPlaying = false
            }
        })
    }
    
    func audioPause(){
        audio!.pause()
        isPlaying = false
        timer?.invalidate()
    }
    
    func addSeconds(_ sec:Double){
        if audio!.currentTime + sec < audio!.duration {
            audio!.currentTime += sec
            self.currentTime += sec
        } else {
            audio!.currentTime = audio!.duration
            self.currentTime = audio!.duration
            audio!.pause()
        }
    }
    
    func reduceSeconds(_ sec:Double){
        if audio!.currentTime - sec > 0 {
            audio!.currentTime -= sec
            self.currentTime -= sec
        } else {
            audio!.currentTime = 0
            self.currentTime = 0
        }
    }
    
    func changeLocation(_ sec:Double){
        if sec < 0 {
            self.audio!.currentTime = 0
            self.currentTime = 0
        }
        else if sec > self.audio!.duration {
            self.audio!.currentTime = self.audio!.duration
            self.currentTime = self.audio!.duration
            audio!.pause()
        }
        else {
            self.audio!.currentTime = sec
            self.currentTime = sec
        }
    }
    
}
