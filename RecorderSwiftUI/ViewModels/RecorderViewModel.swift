//
//  RecorderViewModel.swift
//  RecorderSwiftUI
//
//  Created by Roman Zhukov on 13.03.2022.
//

import Foundation
import AVFoundation

class RecorderViewModel: NSObject, ObservableObject {
    @Published var records: [Record] = []
    private var numberOfRecords = 0
    
    private var audioRecorder: AVAudioRecorder!
    private var audio: AVAudioPlayer!
    
    override init() {
        super.init()
        
        requestRecordPermission()
        
        if let number = UserDefaults.standard.object(forKey: "myNumber") as? Int {
            numberOfRecords = number
        }
    }
    
    func recordButtonAction() {
        if audioRecorder == nil {
            startRecord()
        } else {
            stopRecord()
            records.insert(Record(name: "Новая запись_\(numberOfRecords)", duration: 0), at: 0)
        }
    }
}

extension RecorderViewModel: AVAudioRecorderDelegate {
    private func startRecord() {
        numberOfRecords += 1
        let fileName = getDirectory().appendingPathComponent("\(numberOfRecords).m4a")
        print(fileName)
        let settings = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                        AVSampleRateKey: 1200,
                        AVNumberOfChannelsKey: 1,
                        AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord, options: AVAudioSession.CategoryOptions.mixWithOthers)
            try AVAudioSession.sharedInstance().setActive(true)
            audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            print("record")
            let dateOfRecord = Date().formatted(date: .abbreviated, time: .shortened)
            UserDefaults.standard.set(dateOfRecord, forKey: "\(numberOfRecords)")
        } catch {
            print("Failed recording")
        }
    }
    
    private func stopRecord() {
        audioRecorder.stop()
        print("stop")
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, options: AVAudioSession.CategoryOptions.mixWithOthers)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("ERROR: CANNOT PLAY MUSIC IN BACKGROUND. Message from code: \(error)")
        }
        audioRecorder = nil
        UserDefaults.standard.set(numberOfRecords, forKey: "myNumber")
    }
    
    private func requestRecordPermission() {
        AVAudioSession.sharedInstance().requestRecordPermission { hasPermission in
            if hasPermission {
                print("accepted")
            }
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, options: AVAudioSession.CategoryOptions.mixWithOthers)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Error1")
        }
    }
    
    private func getDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = path[0]
        return documentDirectory
    }
    
    func playRecord() {
        let path = getDirectory().appendingPathComponent("1.m4a")
        do {
            audio = try AVAudioPlayer(contentsOf: path)
            audio.play()
            print("play")
        } catch {
            print("Error")
        }
    }
}
