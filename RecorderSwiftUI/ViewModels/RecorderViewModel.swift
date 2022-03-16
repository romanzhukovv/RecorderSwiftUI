//
//  RecorderViewModel.swift
//  RecorderSwiftUI
//
//  Created by Roman Zhukov on 13.03.2022.
//

import Foundation
import AVFoundation

class RecorderViewModel: NSObject, ObservableObject {
    @Published var records: [RecordCellViewModel] = []
    @Published var isRecord = false
    private var cache: [Record] = []
    private var audioRecorder: AVAudioRecorder!
    
    override init() {
        super.init()
        requestRecordPermission()
        
        if let data = UserDefaults.standard.object(forKey: "myNumber") as? Data {
            guard let records = try? PropertyListDecoder().decode([Record].self, from: data) else { return }
            for record in records {
                self.records.insert(RecordCellViewModel(record: record), at: 0)
            }
        }
        
        print(records.count)
    }
    
    func recordButtonAction() {
        if audioRecorder == nil {
            startRecord()
            isRecord.toggle()
        } else {
            stopRecord()
            isRecord.toggle()
            let path = getDirectory().appendingPathComponent("NewRecord_\(records.count).m4a")
            print(path)
            do {
                let audio = try AVAudioPlayer(contentsOf: path)
                records.insert(RecordCellViewModel(record: Record(name: "NewRecord_\(records.count)",
                                                                  date: Date().formatted(date: .abbreviated, time: .shortened),
                                                                  duration: audio.duration,
                                                                  path: path)), at: 0)
            } catch {
                print("Error")
            }
            
            for record in records {
                cache.insert(record.record, at: 0)
            }
            UserDefaults.standard.set(try? PropertyListEncoder().encode(cache), forKey: "myNumber")
        }
    }
}

extension RecorderViewModel: AVAudioRecorderDelegate {
    private func startRecord() {
        let fileName = getDirectory().appendingPathComponent("NewRecord_\(records.count).m4a")
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
}
