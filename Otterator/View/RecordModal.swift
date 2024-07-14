//
//  RecordModal.swift
//  Otterator
//
//  Created by Bayu Aditya Triwibowo on 13/07/24.
//

import SwiftUI

struct RecordModal: View {
    @Environment(\.dismiss) private var dismiss
    var micRecorder: MicRecorder
    
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                Text(micRecorder.recognizedText)
                    .font(.title)
                    .padding()
                
                
                Spacer()
                Text(formatTime(micRecorder.recordingTime))
                    .font(.system(size: 46, weight: .bold))
                    .padding()
                HStack{
                    Button{
                        micRecorder.isRecording ?
                        micRecorder.pauseRecording() :
                        micRecorder.resumeRecording()
                    } label: {
                        Image(systemName: micRecorder.isRecording ? "pause.fill" : "play.fill")
                            .resizable()
                            .frame(width: 33, height: 41)
                            .foregroundStyle(.red)
                    }
                    
                }
                .padding(.bottom)
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {dismiss()}, label: {
                        Text("Cancel")
                    })
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {/*TODO: Save file*/}, label: {
                        Text("Save")
                    })
                }
            }
            .navigationTitle("Record")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    RecordModal(micRecorder: MicRecorder())
}
