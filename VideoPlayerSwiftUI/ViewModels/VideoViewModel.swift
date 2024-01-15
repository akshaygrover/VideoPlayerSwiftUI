//
//  VideoViewModel.swift
//  VideoPlayerSwiftUI
//
//  Created by Akshay Grover on 2024-01-11.
//

import Foundation
import AVFoundation
import SwiftUI

@MainActor
final class VideoViewModel: ObservableObject {
    private let clientService = ClientService()
    private let urlRequest = URLRequest(url: Constants.URLs.videos!)
    private var videos: [Video] = []
    @Published private(set) var currentVideo: Video?
   
    @Published private(set)var player = AVPlayer()
    @Published private(set) var isPlaying = false
    private var counter: Int = 0
    
    @Published private(set) var errorMessage: ApiError?
    var hasError: Binding<Bool> {
        Binding {
            self.errorMessage != nil
        } set: { _ in
            self.errorMessage = nil
        }
    }
    
    func fetchVideos() async {
        do {
            let response = try await clientService.fetch(type: [Video].self, with: urlRequest)
            let sortedVideos = response.sorted(by: {$0.publishedAt > $1.publishedAt })
            videos = sortedVideos
            currentVideo = sortedVideos.first
            setAVPlayer()
       
        } catch let error as ApiError {
            errorMessage = error
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func playNextVideo() {
        counter += 1
        counter = min(counter, videos.count - 1)
        setCurrentVideo()
        setAVPlayer()
    }
    
    func playPreviousVideo() {
        counter -= 1
        counter = max(0, counter)
        setCurrentVideo()
        setAVPlayer()
    }
    
    func handlePlayPauseVideo() {
        if isPlaying {
            player.pause()
        } else {
            player.play()
        }
        isPlaying.toggle()
    }
    
    private func setCurrentVideo() {
        currentVideo = videos[counter]
    }
    
    func setAVPlayer() {
        if let currentVideo {
            player.replaceCurrentItem(with: AVPlayerItem(url: URL(string: currentVideo.hlsURL)!))
            
        }
    }
}
