//
//  CustomSliderPlayer.swift
//  AudioRedSU
//
//  Created by Dmitrii Onegin on 02.04.2022.
//

import SwiftUI

struct CustomSliderPlayer: View {
    @ObservedObject var viewModel: RecordCellViewModel
    //@ObservedObject var viewModel: AudioEngineViewModel
//    @State private var viewModel: Float = 0.5
 
    let min: Float
    let max: Float
    let width: CGFloat
   
    var lineValue: Float {max - min}
    
    let lineWidth: CGFloat = 2
    let circleWidth: CGFloat = 8
 
    var controlFirst: CGSize {
        CGSize(width: -width/2, height: 0)
    }
    var controlSecond: CGSize {
        CGSize(width: -width/2 + width * CGFloat(viewModel.sliderValue/lineValue), height: 0)
    }
 
    @GestureState private var dragState = CGSize.zero
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            
            let dragGestureSecond = DragGesture()
                .updating($dragState, body: { value, state, transaction in
                    if controlSecond.width + (value.translation.width - state.width) <= width/2  &&
                        controlSecond.width + (value.translation.width - state.width) >= controlFirst.width
                    {
                        viewModel.sliderValue = lineValue * Float((width/2 + controlSecond.width + (value.translation.width - state.width))/width)
                        state = value.translation
                    }
                })
                .onEnded({ _ in
                   
                })
                
            ZStack{

                RoundedRectangle(cornerRadius: 5)
                    .frame(width: width, height: lineWidth)
                    .foregroundColor(.sh_basicGrey)
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: (controlSecond.width) - (controlFirst.width) , height: lineWidth)
                    .offset(x: ((controlFirst.width) + (controlSecond.width))/2, y: 0)
                    .foregroundColor(.customRed)
               
                Circle()
                    .foregroundColor(.sh_darkGrey)
                    .frame(width: circleWidth)
                    .offset(x: controlSecond.width, y: 0)
                    .gesture(dragGestureSecond)
            }
        }
    }
}

//struct CustomSliderPlayer_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomSliderPlayer(viewModel: RecordCellViewModel(record: Record(name: <#T##String#>, date: <#T##String#>, duration: <#T##Double#>, path: <#T##URL#>)), min: 0, max: 320, width: WIDTH - 36)
//            .frame(width: WIDTH - 36, height: 8)
//    }
//}
