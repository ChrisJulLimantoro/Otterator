//
//  Word.swift
//  Otterator
//
//  Created by Bayu Aditya Triwibowo on 12/07/24.
//

import Foundation
import SwiftData

@Model
class WordTranscript {
    var word : String
    var timestamp : Double
    var duration : Double
    var voice_analysis: VoiceAnalyst
    var avg_pitch : Double
    var avg_volume : Double
    var corrected_word : String
    var is_pause: Bool
    
    init(word: String, timestamp: Double, duration: Double, voice_analysis: VoiceAnalyst, avg_pitch: Double, avg_volume: Double, corrected_word: String, is_pause: Bool) {
        self.word = word
        self.timestamp = timestamp
        self.duration = duration
        self.voice_analysis = voice_analysis
        self.avg_pitch = avg_pitch
        self.avg_volume = avg_volume
        self.corrected_word = corrected_word
        self.is_pause = is_pause
    }
}

@Model
class VoiceAnalyst {
    var pitch : [Double]
    var volume : [Double]
    
    init(pitch: [Double], volume: [Double]) {
        self.pitch = pitch
        self.volume = volume
    }
}
    
