//
//  APIRepositoryImplTests.swift
//  TechnicalSMG
//
//  Created by Riad on 04/06/2025.
//

import XCTest
@testable import TechnicalSMG

final class APIRepositoryImplTests: XCTestCase {
    
    /// Tests that fetchPosts returns a non-empty array of post without an error.
    func testFetchPostsReturnsNonEmptyArray() {
        let repository = APIRepositoryImpl()
        
        let expectation = XCTestExpectation(description: "fetchPosts should return a non-empty array without error")
        
        repository.fetchPosts { posts, error in
            XCTAssertNil(error, "Expected no error when fetching posts")
            XCTAssertNotNil(posts, "Expected to receive an array of posts")
            if let posts = posts {
                XCTAssertFalse(posts.isEmpty, "The posts array should not be empty")
                let first = posts.first!
                XCTAssertGreaterThan(first.id, 0, "The first post’s id should be greater than 0")
                XCTAssertFalse(first.title.isEmpty, "The first post’s title should not be empty")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
}
