//
//  Record.swift
//  RecorderSwiftUI
//
//  Created by Roman Zhukov on 13.03.2022.
//

import Foundation

struct Record: Hashable {
    let name: String
    let date = Date()
    let duration: Int
    let isLike = false
}
