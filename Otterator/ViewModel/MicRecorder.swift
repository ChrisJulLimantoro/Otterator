//
//  MicRecorder.swift
//  Otterator
//
//  Created by Bayu Aditya Triwibowo on 13/07/24.
//

import AVFoundation
import Speech
import Observation

@Observable
class MicRecorder {
    private var speechRecognizer = SFSpeechRecognizer()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private var audioEngine = AVAudioEngine()
    private var timer: Timer?
    
    var recognizedText = ""
    var isRecording = false
    var recordingTime: TimeInterval = 0
    var permissionGranted = false
    var showAlert = false
    var alertMessage = ""
    
    init(){
        Task {
            await self.requestPermissions()
        }
    }
    
    func startRecording() {
        guard let speechRecognizer = speechRecognizer, speechRecognizer.isAvailable else {
            return
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        let inputNode = audioEngine.inputNode
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        recognitionRequest.addsPunctuation = true
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            if let result = result {
                self.recognizedText = result.bestTranscription.formattedString
            }
            
            if error != nil || result?.isFinal == true {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
            }
        }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
            startTimer()
            isRecording = true
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
    }
    
    func stopRecording() {
        audioEngine.stop()
        recognitionRequest?.endAudio()
        stopTimer()
        isRecording = false
        recordingTime = 0
    }
    
    func pauseRecording() {
        audioEngine.pause()
        stopTimer()
        isRecording = false
    }
    
    func resumeRecording() {
        do {
            try audioEngine.start()
            startTimer()
            isRecording = true
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
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
    
    func requestPermissions() async {
        var micPerm = await checkMicrophonePermission()
        var speechPerm = requestSpeechRecognizerPermission()
        permissionGranted = micPerm && speechPerm
    }
    
    private func checkMicrophonePermission() async -> Bool {
        if await AVAudioApplication.requestRecordPermission() {
            return true
        } else {
            self.alertMessage = "Microphone access has been denied. Please enable it in settings."
            self.showAlert = true
            return false
        }
    }
    
    private func requestSpeechRecognizerPermission() -> Bool {
        switch SFSpeechRecognizer.authorizationStatus() {
        case .authorized:
            return true
        case .denied, .restricted, .notDetermined:
            self.alertMessage = "Speech recognition access has been denied. Please enable it in settings."
            self.showAlert = true
            return false
        @unknown default:
            return false
        }
    }
    
}
