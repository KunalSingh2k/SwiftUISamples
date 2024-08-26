//
//  Response.swift
//  SwiftUICupcake
//
//  Created by Kunal Kumar R on 22/08/24.
//

import Foundation

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}
