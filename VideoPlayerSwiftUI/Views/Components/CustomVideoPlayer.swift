//
//  VideoPlayerView.swift
//  VideoPlayerSwiftUI
//
//  Created by Akshay Grover on 2024-01-12.
//

import SwiftUI
import AVKit

struct CustomVideoPlayer : UIViewControllerRepresentable {
    var player : AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
}
