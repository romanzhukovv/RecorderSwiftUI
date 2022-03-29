//
//  RecordCellView.swift
//  RecorderSwiftUI
//
//  Created by Roman Zhukov on 13.03.2022.
//

import SwiftUI

struct RecordCellView: View {
//    @Binding var sliderValue: Double
//    @State private var likeIsHidden = true
    @ObservedObject var viewModel: RecordCellViewModel
    
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
            Slider(value: .constant(5), in: 0...10)
            HStack {
                Text("00:02")
                Spacer()
                Text("-00:13")
            }
            HStack(spacing: 40) {
                Button(action: { viewModel.likePressed() }) {
                    Image("Heart")
                }
                Button(action: {}) {
                    Image("RewindButton")
                }
                Button(action: { viewModel.playRecord() }) {
                    Image("PlayButton")
                }
                Button(action: {}) {
                    Image("JumpButton")
                }
                Button(action: {}) {
                    Image("PlusButton")
                }
            }
        }
    }
}

//struct RecordCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordCellView(viewModel: RecordCellViewModel(record: Record(name: "", date: "", duration: 0, isLike: true, path: URL(string: "")!)))
//    }
//}
