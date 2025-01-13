//
//  RemoteFeedLoader.swift
//  EssentialFeedTests
//
//  Created by Mustafa Qutbuddin on 2025-01-13.
//

import XCTest
import EssentialFeed

class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_load_requestsDataFromURL() async {
        let url = URL(string: "www.ihaveaproperURL.com")!
        let (sut, client) = makeSUT(from: url)
        
        try! await sut.load()
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_load_deliversErrorOnClientError() async {
        let (sut, client) = makeSUT()
        client.error = NSError(domain: "Test", code: 0)
        var capturedErrors = [RemoteFeedLoader.Error?]()
        
        do {
            try await sut.load()
            XCTFail("Expected an error")
        } catch {
            capturedErrors.append(error as? RemoteFeedLoader.Error)
        }
        
        XCTAssertEqual(capturedErrors, [.connectivity])
    }
    
    // MARK: - Helpers
    
    private func makeSUT(from url: URL = URL(string: "www.testurl.com")!) -> (RemoteFeedLoader, HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        
        return (sut, client)
    }
    
    private class HTTPClientSpy: HTTPClient {
        var requestedURLs = [URL]()
        var error: Error?
        
        func get(from url: URL) throws {
            if let error {
                throw error
            }
            requestedURLs.append(url)
        }
    }
}
