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
    
    func getPractice(){
        let apiUrl:URL = URL(string:"https://climantoro.pythonanywhere.com/api")!
        let encoder = JSONEncoder()
        var request:URLRequest = URLRequest(url:apiUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        let text = self.transcript!.sorted(by: {$0.timestamp < $1.timestamp}).filter{ !$0.is_pause }.map{
            $0.corrected_word
        }.reduce(""){ $0 + " " + $1 }.trimmingCharacters(in: .whitespaces)
        let message = Message(phrase:text)
        
        request.httpBody = try! encoder.encode(message)
        
        let task = URLSession.shared.dataTask(with:request){ data, response, error in

            let decoder = JSONDecoder()
            
            if let data = data{
                do {
                    let json = try! decoder.decode([JsonPractice].self,from:data)
                    let practices = json.map{
                        Practice(word:$0.text,duration:$0.duration,is_pause:$0.is_pause,timestamp: $0.timestamp)
                    }.sorted(by: {$0.timestamp < $1.timestamp})
                    
                    DispatchQueue.main.async{
                        self.practice = practices
                        print(self.practice!.map{$0.word})
                    }
                } catch  {
                    print(error.localizedDescription)
                }
            }
            
        }
        task.resume()
        
        print(self.practice!.map{$0.word})
    }
}
