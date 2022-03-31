//
//  RecordCellViewModel.swift
//  RecorderSwiftUI
//
//  Created by Roman Zhukov on 15.03.2022.
//

import AVFoundation

class RecordCellViewModel: NSObject, ObservableObject {
    @Published var record: Record
    @Published var currentTime = 0
    
    private var audioPlayer: AVAudioPlayer?
    private var isPlaying = false
    
    init(record: Record) {
        self.record = record
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: record.path)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func playRecord() {
        if !isPlaying {
            audioPlayer?.play()
            updateCurrentTime()
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
    
    private func updateCurrentTime() {
        currentTime = Int(audioPlayer?.currentTime ?? 0)
    }
    
    func updateLeftTime() {
        let currentTime = Int(audioPlayer?.currentTime ?? 0)
        let duration = Int(audioPlayer?.duration ?? 0)
        let leftTime = currentTime - duration
    }
}
