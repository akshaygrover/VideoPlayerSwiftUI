//
//  Video.swift
//  VideoPlayerSwiftUI
//
//  Created by Akshay Grover on 2024-01-11.
//

import Foundation

struct Video: Codable, Identifiable {
    let id: String
    let title: String
    let hlsURL: String
    let fullURL: String
    let description: String
    let publishedAt: Date
    let author: Author
}

struct Author: Codable, Identifiable {
    let id: String
    let name: String
}
