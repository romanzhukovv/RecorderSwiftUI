//
//  Extension + DateFormatter.swift
//  RecorderSwiftUI
//
//  Created by Roman Zhukov on 02.04.2022.
//

import Foundation

extension DateComponentsFormatter {
    static let audioTime: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        
        return formatter
    }()
}
