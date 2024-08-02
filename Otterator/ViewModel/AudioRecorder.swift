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
    var timer: Timer?
    var audioRecorder: AVAudioRecorder!
    var resultRecognition: SFSpeechRecognitionResult!
    var audioPlayer: AVAudioPlayer?
    var modelContext: ModelContext
    var micPermissionGranted = false
    var speechPermissionGranted = false
    
    var recording = false
    var recognizedText: String = ""
    var recordingTime: TimeInterval = 0
    var showAlert = false
    var alertMessage = ""
    
    let settings = [
        AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
        AVSampleRateKey: 12000,
        AVNumberOfChannelsKey: 1,
        AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
    ]
    
    init(modelContext: ModelContext){
        self.modelContext = modelContext
        super.init()
        setup()
    }
    
    func setup() {
        let recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            
            let url = getDocumentsDirectory().appendingPathComponent("recording_\(UUID().uuidString).m4a")
            
            audioRecorder = try AVAudioRecorder(url: url, settings: self.settings)
        } catch {
            print(error)
        }
    }
    
    func startRecording() {
        audioRecorder.record()
        recording = true
        startTimer()
    }
    
    func pauseRecording() {
        audioRecorder.pause()
        recording = false
        stopTimer()
    }
    
    func stopRecording() {
        audioRecorder.stop()
        recording = false
        stopTimer()
        recordingTime = 0
    }
    
    func playRecording(name: String) {
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(.playAndRecord, mode: .default, options: [.allowBluetoothA2DP, .allowBluetooth, .defaultToSpeaker])
            try session.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            debugPrint("error: \(error.localizedDescription)")
        }
        
        let url = getDocumentsDirectory().appendingPathComponent(name)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
            audioPlayer?.volume = 1
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
    
    func checkPermissions() -> Bool {
        Task {
            await checkMicrophonePermission()
            checkSpeechRecognitionPermission()
        }
        if self.micPermissionGranted && self.speechPermissionGranted {
            return true
        } else {
            self.alertMessage = "Microphone and speech permissions are not granted. Please check the settings."
            self.showAlert = true
            return false
        }
    }
    
    func checkMicrophonePermission() async {
        if await AVAudioApplication.requestRecordPermission() {
            self.micPermissionGranted = true
        } else {
            self.micPermissionGranted = false
        }
    }
    
    func checkSpeechRecognitionPermission() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                switch authStatus {
                case .authorized:
                    self.speechPermissionGranted = true
                case .denied, .restricted, .notDetermined:
                    self.speechPermissionGranted = false
                @unknown default:
                    fatalError("Status otorisasi tidak dikenal.")
                }
            }
        }
    }
    
}
