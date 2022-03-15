//
//  RecordCellViewModel.swift
//  RecorderSwiftUI
//
//  Created by Roman Zhukov on 15.03.2022.
//

import Foundation
import AVFoundation

class RecordCellViewModel: NSObject, ObservableObject {
    private var audioPlayer: AVAudioPlayer!
    
    func playRecord(path: URL) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: path)
            audioPlayer.play()
            print("play")
        } catch {
            print("Error")
        }
    }
}
