//
//  RecordModal.swift
//  Otterator
//
//  Created by Bayu Aditya Triwibowo on 13/07/24.
//

import SwiftUI
import SwiftData

struct RecordModal: View {
    @Environment(\.dismiss) private var dismiss
    
    var audioRecorder: AudioRecorder
    
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                Text(audioRecorder.recognizedText)
                    .font(.title)
                    .padding()
                Spacer()
                Text(formatTime(audioRecorder.recordingTime))
                    .font(.system(size: 46, weight: .bold))
                    .padding()
                HStack{
                    Button{
                        // TODO: Start Pause
                    } label: {
                        Image(systemName: audioRecorder.recording ? "pause.fill" : "play.fill")
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
                    Button(action: {audioRecorder.saveRecording(); dismiss()}, label: {
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
    do{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Record.self, configurations: config)
        return RecordModal(audioRecorder: AudioRecorder(modelContext: container.mainContext))
    } catch {
        fatalError("Failed to create model container.")
    }
}
