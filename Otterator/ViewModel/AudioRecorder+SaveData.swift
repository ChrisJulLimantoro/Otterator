//
//  AudioRecorder+SaveData.swift
//  Otterator
//
//  Created by Bayu Aditya Triwibowo on 18/07/24.
//

import Foundation
import Speech

extension AudioRecorder{
    @available(iOS 17, *)
    private var lmConfiguration: SFSpeechLanguageModel.Configuration {
        let outputDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let dynamicLanguageModel = outputDir.appendingPathComponent("LM")
        let dynamicVocabulary = outputDir.appendingPathComponent("Vocab")
        return SFSpeechLanguageModel.Configuration(languageModel: dynamicLanguageModel, vocabulary: dynamicVocabulary)
    }
    
    func saveRecording() {
        stopRecording()
        
        Task{
            do {
                let uuid = UUID().uuidString
                try await transcribeAudio(url: audioRecorder.url)
                
                let wordT = self.mapTranscriptionSegments(segments: resultRecognition.bestTranscription.segments)
                
                let res: Record = Record(title: uuid, audio_file: "\(audioRecorder.url)", datetime: Date(), duration: resultRecognition.speechRecognitionMetadata?.speechDuration ?? 0, transcript: wordT, avg_pitch: 0.0, avg_volume: 0, avg_pause: resultRecognition.speechRecognitionMetadata?.averagePauseDuration ?? 0, avg_pace: resultRecognition.speechRecognitionMetadata?.speakingRate ?? 0)
                
                self.modelContext.insert(res)
            } catch {
                print("Failed to save recording: \(error)")
            }
        }
    }
    
    private func transcribeAudio(url: URL) async throws {
        let recognitionRequest = SFSpeechURLRecognitionRequest(url: url)
        
        recognitionRequest.shouldReportPartialResults = false
        recognitionRequest.addsPunctuation = true
        
        if #available(iOS 13, *) {
            recognitionRequest.requiresOnDeviceRecognition = true
            if #available(iOS 17, *) {
                recognitionRequest.customizedLanguageModel = self.lmConfiguration
            }
        }
        
        do {
            try await withCheckedThrowingContinuation { continuation in
                var isResumed = false // Flag to check if the continuation is already resumed
                speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
                    if let result = result {
                        self.resultRecognition = result
                        if !isResumed {
                            continuation.resume(returning: ())
                            isResumed = true
                        }
                        return
                    }
                    if error != nil || result?.isFinal == true {
                        if !isResumed {
                            continuation.resume(throwing: error!)
                            isResumed = true
                        }
                        return
                    }
                }
            }
        } catch {
            throw error
        }
    }
    
    private func mapTranscriptionSegments(segments: [SFTranscriptionSegment]) -> [WordTranscript] {
        var transcripts: [WordTranscript] = []
        
        for i in 0..<segments.count {
            let segment = segments[i]
            
            if(i < segments.count - 1){
                let pause = checkPause(first: segment, second: segments[i+1])
                if let valPause = pause {
                    transcripts.append(valPause)
                }
            }
            
            let word = segment.substring
            let timestamp = segment.timestamp
            let duration = segment.duration
            let avg_pitch = averageOfFeatures(values: segment.voiceAnalytics?.pitch.acousticFeatureValuePerFrame)
            let avg_volume = averageOfFeatures(values: segment.voiceAnalytics?.shimmer.acousticFeatureValuePerFrame)
            let avg_pace = averageOfFeatures(values: segment.voiceAnalytics?.jitter.acousticFeatureValuePerFrame)
            let corrected_word = segment.substring
            let is_pause = false
            
            let pitchValues = segment.voiceAnalytics?.pitch.acousticFeatureValuePerFrame
            let volumeValues = segment.voiceAnalytics?.shimmer.acousticFeatureValuePerFrame
            let voiceAnalyst = VoiceAnalyst(pitch: pitchValues ?? [0], volume: volumeValues ?? [0])
            
            let transcript = WordTranscript(word: word, timestamp: timestamp, duration: duration, voice_analysis: voiceAnalyst, avg_pitch: avg_pitch, avg_volume: avg_volume, avg_pace: avg_pace, corrected_word: corrected_word, is_pause: is_pause)
            
            transcripts.append(transcript)
        }
        
        return transcripts
    }
    
    private func averageOfFeatures(values: [Double]?) -> Double {
        guard let values = values else {return 0.0}
        return values.reduce(0.0, +) / Double(values.count)
    }
    
    private func checkPause(first: SFTranscriptionSegment, second: SFTranscriptionSegment) -> WordTranscript? {
        let firstEnd = first.timestamp + first.duration
        let pause = second.timestamp - firstEnd
        if(pause > 0.1){
            let pauseItem = WordTranscript(word: "//", timestamp: firstEnd, duration: pause, avg_pitch: 0, avg_volume: 0, avg_pace: 0, corrected_word: "nil", is_pause: true)
            return pauseItem
        } else {
            return nil
        }
    }
}
