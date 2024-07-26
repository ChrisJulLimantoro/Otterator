//
//  Practice.swift
//  Otterator
//
//  Created by Christopher Julius on 23/07/24.
//

import Foundation
import SwiftData

@Model
class Practice{
    var word:String
    var duration: Double
    var is_pause:Bool
    var timestamp: Double
    
    init(word:String, duration:Double, is_pause:Bool, timestamp:Double){
        self.word = word
        self.duration = duration
        self.is_pause = is_pause
        self.timestamp = timestamp
    }
}


class JsonPractice:Codable{
    var text:String
    var duration: Double
    var is_pause:Bool
    var timestamp: Double
    
    init(text:String, duration:Double, is_pause:Bool, timestamp:Double){
        self.text = text
        self.duration = duration
        self.is_pause = is_pause
        self.timestamp = timestamp
    }
}
