//
//  RecorderViewModel.swift
//  RecorderSwiftUI
//
//  Created by Roman Zhukov on 13.03.2022.
//

import AVFoundation

class RecorderViewModel: ObservableObject {
    @Published var records: [RecordCellViewModel] = []
    @Published var isRecord = false
    private var audioRecorder: AVAudioRecorder?

    init() {
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
            
            records.insert(RecordCellViewModel(record: Record(name: "NewRecord_\(records.count)",
                                                              date: Date().formatted(date: .abbreviated, time: .omitted),
                                                              path: path)), at: 0)
          
            
            let recordsCache = Array(records.map { $0.record }.reversed())
            
            UserDefaults.standard.set(try? PropertyListEncoder().encode(recordsCache), forKey: "myNumber")
        }
    }
}

extension RecorderViewModel {
    private func startRecord() {
        let fileName = getDirectory().appendingPathComponent("NewRecord_\(records.count).m4a")
        let settings = [AVFormatIDKey: kAudioFormatAppleLossless,
                        AVSampleRateKey: 44100,
                        AVNumberOfChannelsKey: 1,
                        AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue] as [String : Any]
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord, options: AVAudioSession.CategoryOptions.mixWithOthers)
            try AVAudioSession.sharedInstance().setActive(true)
            audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
            audioRecorder?.record()
            print("record")
        } catch {
            print("Failed recording")
        }
    }
    
    
    private func stopRecord() {
        audioRecorder?.stop()
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
