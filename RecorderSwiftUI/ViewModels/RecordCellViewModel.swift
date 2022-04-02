//
//  RecordCellViewModel.swift
//  RecorderSwiftUI
//
//  Created by Roman Zhukov on 15.03.2022.
//

import AVFoundation

class RecordCellViewModel: NSObject, ObservableObject {
    @Published var record: Record
    @Published var audioPlayer: AVAudioPlayer?
    @Published var isPlaying = false
    @Published var sliderValue: Float = 0
    
    
    init(record: Record) {
        self.record = record
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: record.path)
        } catch {
            print(error)
        }
    }
    
    func playRecord() {
//        sliderValue = Float(audioPlayer?.currentTime ?? 0) / Float(audioPlayer?.duration ?? 0)
        if !isPlaying {
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            isPlaying.toggle()
            print("play")
        } else {
            audioPlayer?.pause()
            isPlaying.toggle()
            print("pause")
        }
    }
    
    func likePressed() {
        record.isLike.toggle()
    }
    
    func jumpButtonAction() {
        audioPlayer?.currentTime += 3
    }
    
    func rewindButtonAction() {
        audioPlayer?.currentTime -= 3
    }
}
