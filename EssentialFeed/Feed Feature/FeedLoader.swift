//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Mustafa Qutbuddin on 2025-01-12.
//

import Foundation

protocol FeedLoader {
    func load(_ feedItems: [FeedItem]) async throws
}
