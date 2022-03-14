//
//  RecordCellView.swift
//  RecorderSwiftUI
//
//  Created by Roman Zhukov on 13.03.2022.
//

import SwiftUI

struct RecordCellView: View {
    @Binding var sliderValue: Double
    
    var body: some View {
        VStack {
            HStack {
                Text("Новая запись")
                Spacer()
                Text("00:15")
            }
            Text("10 окт. 2021")
                .frame(maxWidth: .infinity, alignment: .leading)
            Slider(value: $sliderValue, in: 0...10)
            HStack {
                Text("00:02")
                Spacer()
                Text("-00:13")
            }
            HStack(spacing: 40) {
                Button(action: {}) {
                    Image("Heart")
                }
                Button(action: {}) {
                    Image("RewindButton")
                }
                Button(action: {}) {
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

struct RecordCellView_Previews: PreviewProvider {
    static var previews: some View {
        RecordCellView(sliderValue: .constant(5))
    }
}
