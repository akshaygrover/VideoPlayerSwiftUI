//
//  VideoViewModel.swift
//  VideoPlayerSwiftUI
//
//  Created by Akshay Grover on 2024-01-11.
//

import Foundation

@MainActor
final class VideoViewModel: ObservableObject {
    private let clientService = ClientService()
    private let urlRequest = URLRequest(url: Constants.URLs.videos!)
    @Published private(set) var videos: [Video] = []
    @Published private(set) var errorMessage: String = ""
    @Published var hasError: Bool = false
    
    func fetchVideos() async {
        do {
            let response = try await clientService.fetch(type: [Video].self, with: urlRequest)
            let sortedVideos = response.sorted(by: {$0.publishedAt > $1.publishedAt })
            videos = sortedVideos
        } catch let error as ApiError {
            errorMessage = error.customDescription
            hasError = true
        } catch {
            errorMessage = error.localizedDescription
            hasError = true
        }
    }
}
