//
//  Record.swift
//  Otterator
//
//  Created by Bayu Aditya Triwibowo on 12/07/24.
//

import Foundation
import SwiftData

@Model
class Record {
    var id: UUID
    var title: String
    var audio_file: String
    var datetime: Date
    var duration: Double
    var transcript: [WordTranscript]?
    var avg_pitch : Double
    var avg_volume : Double
    var avg_pause : Double
    var avg_pace : Double
    var practice: [Practice]?
    var version: Int = 0
    var practiceVersion:Int = 0
    
    init(id: UUID = UUID(), title: String, audio_file: String, datetime: Date, duration: Double, transcript: [WordTranscript]?, avg_pitch: Double, avg_volume: Double, avg_pause: Double, avg_pace: Double) {
        self.id = id
        self.title = title
        self.audio_file = audio_file
        self.datetime = datetime
        self.duration = duration
        self.transcript = transcript
        self.avg_pitch = avg_pitch
        self.avg_volume = avg_volume
        self.avg_pause = avg_pause
        self.avg_pace = avg_pace
    }
}
