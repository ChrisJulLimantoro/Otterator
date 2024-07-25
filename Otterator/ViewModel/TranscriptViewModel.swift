//
//  TranscriptViewModel.swift
//  Otterator
//
//  Created by Christopher Julius on 15/07/24.
//

import Foundation
import AVFoundation
import SwiftUI
import QuartzCore

@Observable
class TranscriptViewModel {
    
    var audio:AVAudioPlayer?
    
    var text:[WordTranscript] = []
    
    var isPlaying: Bool = false
    var currentTime:Double = 0
    var timer:Timer?
    var displayLink: CADisplayLink?
    var record: Record
    
    init(_ t_record: Record){
        self.record = t_record
        do{
            let url = getDocumentsDirectory().appendingPathComponent(t_record.audio_file)
            audio = try AVAudioPlayer(contentsOf: url)
            text = t_record.transcript!.sorted(by: {$0.timestamp < $1.timestamp})
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
        setupDisplayLink()
    }
    
    private func setupDisplayLink() {
        displayLink = CADisplayLink(target: self, selector: #selector(updateCurrentTime))
        displayLink?.add(to: .main, forMode: .default)
    }
    
    @objc private func updateCurrentTime() {
        if let audioPlayer = self.audio, audioPlayer.isPlaying  {
            withAnimation(.easeInOut) {
                self.currentTime = audioPlayer.currentTime
            }
        } else {
            displayLink?.invalidate()
            displayLink = nil
            self.isPlaying = false
        }
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
