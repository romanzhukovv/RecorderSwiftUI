//
//  RecordCellViewModel.swift
//  RecorderSwiftUI
//
//  Created by Roman Zhukov on 15.03.2022.
//

import Foundation
import AVFoundation

class RecordCellViewModel: NSObject, ObservableObject {
    var record: Record
    private var audioPlayer: AVAudioPlayer!
    
    init(record: Record) {
        self.record = record
    }
    
    func playRecord() {
        print(record.path)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: record.path)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            print("play")
        } catch {
            print(error.localizedDescription)
        }
    }
}
