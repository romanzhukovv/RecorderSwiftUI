//
//  RecordCellView.swift
//  RecorderSwiftUI
//
//  Created by Roman Zhukov on 13.03.2022.
//

import SwiftUI

struct RecordCellView: View {
    @ObservedObject var viewModel: RecordCellViewModel
    @State private var currentTime = 0.0
    @State private var leftTime = 0.0
    @Binding var cellID: UUID
    
    private let timer = Timer.publish(every: 0.1, on: .main , in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                TextField(viewModel.record.name, text: $viewModel.record.name)
                    .font(fontBold16)
                    .foregroundColor(Color.sh_basicGrey)
                Spacer()
                Image("Heart2")
                    .padding(.trailing, 36)
                    .opacity(viewModel.record.isLike ? 1 : 0)
                Text(DateComponentsFormatter.audioTime.string(from: viewModel.audioPlayer?.duration ?? 0) ?? "00:00")
                    .font(fontRegular12)
                    .foregroundColor(Color.sh_basicGrey)
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 18))
            
            Text("\(viewModel.record.date)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 10, leading: 18, bottom: 0, trailing: 18))
                .font(fontRegular12)
                .foregroundColor(Color.sh_basicGrey)
            
            
            
            if cellID == viewModel.record.id {
                CustomSliderPlayer(viewModel: viewModel, min: 0, max: 320, width: WIDTH - 44)
                    .frame(width: WIDTH - 44, height: 8)
                    .padding(.top, 12)
    //            Slider(value: $currentTime, in: 0.0...(viewModel.audioPlayer?.duration ?? 0.0))
    //                .onChange(of: currentTime) { newValue in
    //                    viewModel.audioPlayer?.currentTime = newValue
    //                }
                HStack {
                    Text(DateComponentsFormatter.audioTime.string(from: currentTime) ?? "00:00")
                        .font(fontRegular12)
                        .foregroundColor(Color.sh_basicGrey)
                    Spacer()
                    Text(DateComponentsFormatter.audioTime.string(from: leftTime) ?? "00:00")
                        .font(fontRegular12)
                        .foregroundColor(Color.sh_basicGrey)
                }
                .padding(EdgeInsets(top: 2, leading: 18, bottom: 0, trailing: 18))
                
                HStack(spacing: 0) {
                    Button(action: { viewModel.likePressed() }) {
                        Image("Heart")
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 50))
                    Button(action: { viewModel.rewindButtonAction() }) {
                        Image("RewindButton")
                    }
                    .padding(.trailing, 28)
                    Button(action: { viewModel.playRecord() }) {
                        viewModel.isPlaying ? Image("PauseButton") : Image("PlayButton")
                    }
                    Button(action: { viewModel.jumpButtonAction() }) {
                        Image("JumpButton")
                    }
                    .padding(.leading, 28)
                    Button(action: {}) {
                        Image("PlusButton")
                    }
                    .padding(EdgeInsets(top: 0, leading: 53, bottom: 5, trailing: 0))
                }
                .padding(.top, 23)
                
                Divider().background(Color.sh_basicGrey)
                    .padding(EdgeInsets(top: 22, leading: 18, bottom: 0, trailing: 0))
            } else {
                Divider().background(Color.sh_basicGrey)
                    .padding(EdgeInsets(top: 11, leading: 18, bottom: 0, trailing: 0))
            }
            
        }.onReceive(timer) { _ in
            currentTime = viewModel.audioPlayer?.currentTime ?? 0.0
            leftTime = currentTime - (viewModel.audioPlayer?.duration ?? 0.0)
        }
    }
}

//struct RecordCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack {
//            RecordCellView(viewModel: RecordCellViewModel(record: Record(name: "", date: "", duration: 0, isLike: true, path: URL(string: "")!)))
//        }
//    }
//}
