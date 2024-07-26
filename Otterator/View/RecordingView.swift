//
//  RecordingView.swift
//  Otterator
//
//  Created by Bayu Aditya Triwibowo on 12/07/24.
//

import SwiftUI
import SwiftData

struct RecordingView: View {
    @State private var searchText = ""
    @State private var showModal = false
    @Query var records: [Record]
    @Bindable private var audioRecorder: AudioRecorder
    @Environment(\.modelContext) private var modelContext
    
    init(modelContext: ModelContext) {
        let audioRecorder = AudioRecorder(modelContext: modelContext)
        _audioRecorder = Bindable(wrappedValue: audioRecorder)
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    ForEach(records) { item in
                        CustomListTile(item:item)
                    }
                }
                .background(Color.oBackground)
                .listStyle(.inset)
                Spacer()
                //Recording button
                Button{
                    showModal.toggle()
                    audioRecorder.startRecording()
                } label: {
                    ZStack{
                        Circle()
                            .fill(Color.white)
                            .frame(width: 52, height: 52)
                            .shadow(color: Color(hex: "#555555"), radius: 0, x: 3, y: 3)
                        Circle()
                            .fill(Color.accentColor)
                            .frame(width: 30, height: 30)
                            .padding(-2)
                    }.padding(.top)
                }
                .frame(maxWidth: .infinity)
                .background(Color.oBackground)
            }
            .scrollContentBackground(.hidden)
            .background(Color.oBackground)
            .navigationTitle("All Recordings")
            .toolbar{
                ToolbarItemGroup(placement: .topBarTrailing) {
                    EditButton()
                }
            }
            .toolbarBackground(Color.oBackground, for: .navigationBar)
            .searchable(text: $searchText)
        }
        .sheet(
            isPresented: $showModal,
            onDismiss: {audioRecorder.stopRecording()}
        ){
            RecordModal(stateModal: $showModal, audioRecorder: audioRecorder)
                .interactiveDismissDisabled()
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(records[index])
            }
        }
    }
}

#Preview {
    do{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Record.self, configurations: config)
        for _ in (0...3) {
            let rec = Record(id: UUID(), title: "adsad", audio_file: "asdasd", datetime: Date(), duration: 0, transcript: [], avg_pitch: 0, avg_volume: 0, avg_pause: 0, avg_pace: 0)
            container.mainContext.insert(rec)
        }
        return RecordingView(modelContext: container.mainContext)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
