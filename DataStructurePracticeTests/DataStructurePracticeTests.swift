//
//  DataStructurePracticeTests.swift
//  DataStructurePracticeTests
//
//  Created by Kevin Taniguchi on 1/13/16.
//  Copyright © 2016 Taniguchi. All rights reserved.
//

import XCTest
@testable import DataStructurePractice

class DataStructurePracticeTests: XCTestCase {
    
    let testLinkedList = LinkedList<Int>()
    let testBinarySearchTree = BSTree<Int>()
    
    override func setUp() {
        super.setUp()
        
        for index in 1...10 {
            testLinkedList.addNode(index)
            testBinarySearchTree.addNode(index)
        }
    }
    
    func testBinarySearchTreeCreation() {
        // this is a bad test b/c it doesn't really check to see if all the nodes were added
        XCTAssertNotNil(testBinarySearchTree)
    }
    
    func testBinarySearchTreeAddedAllNodes() {
    }
    
    func testBinarySearchTreeLowestValue() {
        
    }
    
    func testLinkedListCreation() {
        // this is a bad test b/c it doesn't really check to see if all the nodes were added
        XCTAssertNotNil(testLinkedList)
        // this is a better test
        XCTAssertEqual(10, testLinkedList.count)
    }
    
    func testLinkedListIterativeReverse() {
        
    }
    
    func testLinkedListRecursiveReverse() {
        
    }
}
