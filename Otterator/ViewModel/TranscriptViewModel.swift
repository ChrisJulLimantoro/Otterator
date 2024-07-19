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
    
    var text:[WordTranscript] = [
        WordTranscript(word: "hai,", timestamp: 0, duration: 0.3, voice_analysis: VoiceAnalyst(pitch: [0.0,0.4,0.1,0.3], volume: [50,0.1,0.2,4.2]), avg_pitch: 0.1, avg_volume: 25, avg_pace : 5, corrected_word: "hai,", is_pause: false),
        WordTranscript(word: "//", timestamp: 0.3, duration: 0.2, voice_analysis: VoiceAnalyst(pitch: [], volume: [50,0.1,0.2,4.2]), avg_pitch: 0.2, avg_volume: 20,avg_pace : 12, corrected_word: "", is_pause: true),
        WordTranscript(word: "how", timestamp: 0.5, duration: 0.2, voice_analysis: VoiceAnalyst(pitch: [0.0,0.4,0.1,0.3], volume: [50,0.1,0.2,4.2]), avg_pitch: 0.8, avg_volume: 12,avg_pace : 3, corrected_word: "how", is_pause: false),
        WordTranscript(word: "are", timestamp: 0.7, duration: 0.3, voice_analysis: VoiceAnalyst(pitch: [0.0,0.4,0.1,0.3], volume: [50,0.1,0.2,4.2]), avg_pitch: 0.5, avg_volume: 20,avg_pace : 15, corrected_word: "are", is_pause: false),
        WordTranscript(word: "you?", timestamp: 1, duration: 0.3, voice_analysis: VoiceAnalyst(pitch: [0.0,0.4,0.1,0.3], volume: [50,0.1,0.2,4.2]), avg_pitch: 0.5, avg_volume: 65,avg_pace : 16, corrected_word: "", is_pause: false),
        WordTranscript(word: "//", timestamp: 1.3, duration: 0.5, voice_analysis: VoiceAnalyst(pitch: [0.0,0.4,0.1,0.3], volume: [50,0.1,0.2,4.2]), avg_pitch: 0.1, avg_volume: 45,avg_pace : 2, corrected_word: "", is_pause: true),
        WordTranscript(word: "i'm", timestamp: 1.8, duration: 0.3, voice_analysis: VoiceAnalyst(pitch: [0.0,0.4,0.1,0.3], volume: [50,0.1,0.2,4.2]), avg_pitch: 0.85, avg_volume: 20,avg_pace : 14, corrected_word: "i'm", is_pause: false),
        WordTranscript(word: "fine", timestamp: 2.1, duration: 0.2, voice_analysis: VoiceAnalyst(pitch: [0.0,0.4,0.1,0.3], volume: [50,0.1,0.2,4.2]), avg_pitch: 0.2, avg_volume: 20,avg_pace : 11, corrected_word: "fond", is_pause: false),
        WordTranscript(word: "too.", timestamp: 2.3, duration: 0.3, voice_analysis: VoiceAnalyst(pitch: [0.0,0.4,0.1,0.3], volume: [50,0.1,0.2,4.2]), avg_pitch: 0.2, avg_volume: 55,avg_pace : 10, corrected_word: "too.", is_pause: false)
    ]
    
    var isPlaying: Bool = false
    var currentTime:Double = 0
    var timer:Timer?
    
    init(_ record: Record){
        do{
            let url = getDocumentsDirectory().appendingPathComponent(record.audio_file)
            audio = try AVAudioPlayer(contentsOf: url)
            text = record.transcript!
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
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
