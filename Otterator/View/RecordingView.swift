//
//  RecordingView.swift
//  Otterator
//
//  Created by Bayu Aditya Triwibowo on 12/07/24.
//

import SwiftUI

struct RecordingView: View {
    @State private var searchText = ""
    @State private var showModal = false
    @Bindable private var micRecorder = MicRecorder()
    
    var body: some View {
        NavigationView{
            VStack{
                List{
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
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            // TODO: delete item from swift data
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
                .listStyle(.inset)
                Spacer()
                Button{
                    showModal.toggle()
                    micRecorder.startRecording()
                } label: {
                    Circle()
                        .fill(micRecorder.permissionGranted ? Color.red : Color.gray)
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
                .disabled(!micRecorder.permissionGranted)
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
            onDismiss: {micRecorder.stopRecording()}
        ){
            RecordModal(micRecorder: micRecorder)
                .interactiveDismissDisabled()
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
        .alert(isPresented: $micRecorder.showAlert) {
            Alert(title: Text("Permission Denied"),
                  message: Text(micRecorder.alertMessage),
                  dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    RecordingView()
}
