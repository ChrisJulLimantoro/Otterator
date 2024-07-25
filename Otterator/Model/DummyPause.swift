//
//  DummyPause.swift
//  Otterator
//
//  Created by Alvin Lionel on 18/07/24.
//

import Foundation

struct PauseTranscript: Identifiable {
    var id: UUID = UUID()
    var word: String
    var duration: Double
    var is_pause: Bool
    
    init(word: String, duration: Double, is_pause: Bool) {
        self.word = word
        self.duration = duration
        self.is_pause = is_pause
    }
}
