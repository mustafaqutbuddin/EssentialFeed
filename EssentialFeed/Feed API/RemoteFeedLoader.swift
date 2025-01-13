//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Mustafa Qutbuddin on 2025-01-13.
//

import Foundation

public protocol HTTPClient {
    func get(from url: URL) async throws
}

public final class RemoteFeedLoader {
    private var url: URL
    private var client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
    }
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load() async throws {
        do {
            try await client.get(from: url)
        } catch {
            throw Error.connectivity
        }
    }
    
}
