//
//  VideoService.swift
//  VideoPlayerSwiftUI
//
//  Created by Akshay Grover on 2024-01-11.
//

import Foundation

final class ClientService: GenericApi {
    var session: URLSession
    
    init(configuration: URLSessionConfiguration) {
     self.session = URLSession(configuration: configuration)
    }

    convenience init() {
     self.init(configuration: .default)
    }

}
