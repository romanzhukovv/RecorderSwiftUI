//
//  Record.swift
//  RecorderSwiftUI
//
//  Created by Roman Zhukov on 13.03.2022.
//

import Foundation

struct Record: Hashable, Codable {
    var id = UUID()
    let name: String
    let date: String
    var isLike = false
    let path: URL
}
