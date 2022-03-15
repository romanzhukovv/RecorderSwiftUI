//
//  Record.swift
//  RecorderSwiftUI
//
//  Created by Roman Zhukov on 13.03.2022.
//

import Foundation

struct Record: Hashable, Codable {
    let name: String
    let date: String
    let duration: Double
    var isLike = false
    let path: URL
}
