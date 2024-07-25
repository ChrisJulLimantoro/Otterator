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
        
//        UINavigationBar.appearance().largeTitleTextAttributes = [.font : Font.custom("PlaypenSans-Regular_Bold", size: 32, relativeTo: .largeTitle)]
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    //Dummy
                    VStack{
                        HStack{
                            Text("Latihan Presentasi MC3")
                                .foregroundStyle(.primary)
                            Spacer()
                        }
                        HStack{
                            Text("5 Jul 2024")
                            Spacer()
                            Text("12.20")
                        }.foregroundStyle(.secondary)
                    }
                    .background(CardBackground(bgcolor: .white))
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            // TODO: delete item from swift data
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                    //Records
                    ForEach(records) { item in
                        ZStack {
                            NavigationLink(destination: TranscriptView(viewModel: TranscriptViewModel(item))) { EmptyView()
                            }.opacity(0.0)
                            VStack{
                                HStack{
                                    Text(item.title)
                                        .foregroundStyle(.primary)
                                    Spacer()
                                }
                                HStack{
                                    Text(item.datetime.formatted(date: .long, time: .omitted))
                                    Spacer()
                                    Text("\(formatTime(item.duration))")
                                }
                                .foregroundStyle(.secondary)
                            }
                        }
                        .background(CardBackground(bgcolor: .white))
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                // TODO: delete item from swift data
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
                .listStyle(.inset)
                Spacer()
                //Recording button
                Button{
                    showModal.toggle()
                    audioRecorder.startRecording()
                } label: {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 52, height: 52)
                        .overlay(
                            Circle()
                                .stroke(Color(.secondaryLabel), lineWidth: 2)
                                .padding(-2)
                        )
                        .padding(.top)
                }
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray6))
            }
            .navigationTitle("All Recordings")
            .toolbar{
                ToolbarItemGroup(placement: .topBarTrailing) {
                    EditButton()
                }
            }
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
    
    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
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
        return RecordingView(modelContext: container.mainContext)
    } catch {
        fatalError("Failed to create model container.")
    }
}
