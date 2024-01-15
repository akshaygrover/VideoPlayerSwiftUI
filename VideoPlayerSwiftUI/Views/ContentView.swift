//
//  ContentView.swift
//  VideoPlayerSwiftUI
//
//  Created by Michael Gauthier on 2021-01-06.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = VideoViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    CustomVideoPlayer(player: viewModel.player)
                    HStack {
                        Button {
                            viewModel.playPreviousVideo()
                        } label: {
                            Image("previous")
                                .scaledToFit()
                            
                        }
                        Button {
                            viewModel.handlePlayPauseVideo()
                        } label: {
                            Image( viewModel.isPlaying ? "pause" : "play")
                                .scaledToFit()
                            
                        }
                        Button {
                            viewModel.playNextVideo()
                        } label: {
                            Image("next")
                                .scaledToFit()
                        }
                    }
                    .padding()
                    
                }
                .frame(width: 400, height: 300, alignment: .top)
                ScrollView {
                    if let currentVideo = viewModel.currentVideo {
                        VStack(alignment: .leading) {
                            Text("Title: \(currentVideo.title)")
                                .font(.title2)
                            Text(currentVideo.description)
                                .font(.subheadline)
                            Text("Author: \(currentVideo.author.name)")
                                .font(.headline)
                            Text("Published: \(currentVideo.publishedAt.formatted())")
                                .font(.title3)
                            
                            
                        }
                        .padding()
                    }
                }
            }
            .alert(isPresented: viewModel.hasError, error: viewModel.errorMessage, actions: { _ in }, message: { error in
                Text(error.errorDescription ?? "Error")
            })
            .navigationTitle("Video Player")
            .navigationBarTitleDisplayMode(.inline)
            
        }
        .task {
            await viewModel.fetchVideos()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


