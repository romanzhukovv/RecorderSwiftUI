//
//  RecordCellView.swift
//  RecorderSwiftUI
//
//  Created by Roman Zhukov on 13.03.2022.
//

import SwiftUI

struct RecordCellView: View {
    @State private var currentTime = 0.0
    @State private var leftTime = 0.0
    @ObservedObject var viewModel: RecordCellViewModel
    
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            HStack {
                Text("\(viewModel.record.name)")
                Spacer()
                Image("Heart2")
                    .padding(.trailing, 30)
                    .opacity(viewModel.record.isLike ? 1 : 0)
                Text("\(viewModel.record.duration)")
            }
            Text("\(viewModel.record.date)")
                .frame(maxWidth: .infinity, alignment: .leading)
            Slider(value: $currentTime, in: 0.0...(viewModel.audioPlayer?.duration ?? 0.0))
                .onChange(of: currentTime) { newValue in
                    viewModel.audioPlayer?.currentTime = newValue
                }
            HStack {
                Text("\(currentTime)")
                Spacer()
                Text("\(leftTime)")
            }
            HStack(spacing: 40) {
                Button(action: { viewModel.likePressed() }) {
                    Image("Heart")
                }
                Button(action: { viewModel.rewindButtonAction() }) {
                    Image("RewindButton")
                }
                Button(action: { viewModel.playRecord() }) {
                    viewModel.isPlaying ? Image(systemName: "pause.fill") : Image("PlayButton")
                }
                Button(action: { viewModel.jumpButtonAction() }) {
                    Image("JumpButton")
                }
                Button(action: {}) {
                    Image("PlusButton")
                }
            }
        }.onReceive(timer) { _ in
            currentTime = viewModel.audioPlayer?.currentTime ?? 0.0
            leftTime = currentTime - (viewModel.audioPlayer?.duration ?? 0.0)
        }
    }
}

//struct RecordCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordCellView(viewModel: RecordCellViewModel(record: Record(name: "", date: "", duration: 0, isLike: true, path: URL(string: "")!)))
//    }
//}
