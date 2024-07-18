//
//  AudioRecorder.swift
//  Otterator
//
//  Created by Bayu Aditya Triwibowo on 17/07/24.
//

import Foundation
import AVFoundation
import Speech
import SwiftData

@Observable
class AudioRecorder: NSObject, AVAudioPlayerDelegate {
    var speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    var audioRecorder: AVAudioRecorder!
    var timer: Timer?
    var recording = false
    var audioPlayer: AVAudioPlayer?
    var resultRecognition: SFSpeechRecognitionResult!
    
    var modelContext: ModelContext
    var recognizedText: String = ""
    var recordingTime: TimeInterval = 0
    
    init(modelContext: ModelContext){
        self.modelContext = modelContext
    }
    
    func startRecording() {
        let recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            let url = getDocumentsDirectory().appendingPathComponent("recording_\(UUID().uuidString).m4a")
            
            audioRecorder = try AVAudioRecorder(url: url, settings: settings)
            audioRecorder.record()
            
            recording = true
            startTimer()
        } catch {
            // Handle error
        }
    }
    
    func stopRecording() {
        audioRecorder.stop()
        recording = false
        stopTimer()
    }
    
    func playRecording(name: String) {
        let playSession = AVAudioSession.sharedInstance()
        
        do {
            try playSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {
            print("Failed")
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(string: name)!)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print(error)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.recordingTime += 1
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
