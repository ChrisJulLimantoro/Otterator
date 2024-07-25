//
//  PitchAnalyzer.swift
//  Otterator
//
//  Created by Bayu Aditya Triwibowo on 25/07/24.
//

import Foundation
import AVFoundation

import AVFoundation

class PitchAnalyzer {
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var pitchNode: AVAudioUnitTimePitch!
    
    init() {
        audioEngine = AVAudioEngine()
        audioPlayerNode = AVAudioPlayerNode()
        pitchNode = AVAudioUnitTimePitch()
        
        audioEngine.attach(audioPlayerNode)
        audioEngine.attach(pitchNode)
        
        audioEngine.connect(audioPlayerNode, to: pitchNode, format: nil)
        audioEngine.connect(pitchNode, to: audioEngine.mainMixerNode, format: nil)
    }
    
    func analyzePitch(from url: URL, completion: @escaping (Double) -> Void) {
        let audioFile = try! AVAudioFile(forReading: url)
        let format = audioFile.processingFormat
        let outputFormat = audioEngine.outputNode.outputFormat(forBus: 0)
        
        audioPlayerNode.scheduleFile(audioFile, at: nil, completionHandler: nil)
        
        audioEngine.outputNode.installTap(onBus: 0, bufferSize: 4096, format: outputFormat) { (buffer, time) in
            let frameCount = Int(buffer.frameLength)
            let channels = UnsafeBufferPointer(start: buffer.floatChannelData, count: Int(buffer.format.channelCount))
            
            var sum: Float = 0.0
            for frame in 0..<frameCount {
                sum += channels[0][frame]
            }
            
            let rms = sqrt(sum / Float(frameCount))
            let pitch = 69 + 12 * log2(Double(rms) / 440.0)
            completion(pitch)
            
            self.audioEngine.outputNode.removeTap(onBus: 0)
        }
        
        do {
            try audioEngine.start()
            audioPlayerNode.play()
        } catch {
            print("AudioEngine failed to start: \(error.localizedDescription)")
        }
    }
}
