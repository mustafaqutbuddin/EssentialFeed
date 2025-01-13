//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Mustafa Qutbuddin on 2025-01-13.
//

import Foundation

public protocol HTTPClient {
    func get(from url: URL)
}

public final class RemoteFeedLoader {
    private var url: URL
    private var client: HTTPClient
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load() {
        client.get(from: url)
    }
    
}
