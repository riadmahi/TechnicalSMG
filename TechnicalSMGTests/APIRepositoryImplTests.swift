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
    
    
    /// Tests that fetchComments returns at least one Comment without an error.
    func testFetchCommentsReturnsNonEmptyArray() {
        let repository = APIRepositoryImpl()
        let expectation = XCTestExpectation(description: "fetchComments should return a non-empty array without error")
        
        // Use postId = 1, which is known to have comments in JSONPlaceholder
        repository.fetchComments(for: 1) { comments, error in
            XCTAssertNil(error, "Expected no error when fetching comments")
            XCTAssertNotNil(comments, "Expected to receive an array of comments")
            
            if let comments = comments {
                XCTAssertFalse(comments.isEmpty, "The comments array should not be empty")
                
                let first = comments.first!
                XCTAssertEqual(first.postId, 1, "The first comment’s postId should match the requested postId")
                XCTAssertGreaterThan(first.id, 0, "The first comment’s id should be greater than 0")
                XCTAssertFalse(first.name.isEmpty, "The first comment’s name should not be empty")
                XCTAssertFalse(first.body.isEmpty, "The first comment’s body should not be empty")
                XCTAssertFalse(first.email.isEmpty, "The first comment’s email should not be empty")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    /// Tests that createPost returns a post with correct values and no error.
    func testCreatePostReturnsValidPost() {
        let repository = APIRepositoryImpl()
        let expectation = XCTestExpectation(description: "createPost should return a valid Post without error")

        let fakeTitle = "Fake Post Title"
        let fakeBody = "This is the body of the fake post"

        repository.createPost(title: fakeTitle, body: fakeBody) { post, error in
            XCTAssertNil(error, "Expected no error when creating post")
            XCTAssertNotNil(post, "Expected a valid post object")

            if let post = post {
                XCTAssertEqual(post.title, fakeTitle, "Returned post title should match input")
                XCTAssertEqual(post.body, fakeBody, "Returned post body should match input")
                XCTAssertEqual(post.userId, 1, "User ID should be 1 for the mock API")
                XCTAssertGreaterThan(post.id, 0, "Returned post ID should be greater than 0")
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }
}
