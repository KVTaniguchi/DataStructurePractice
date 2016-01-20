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
        var current: LinkedListNode? = testLinkedList.head
        
        while current != nil {
            if current?.nextNode != nil {
                let childNode: LinkedListNode = (current?.nextNode)!
                print("KEY : \(childNode.key)")
                current?.nextNode = childNode
                break
            }
            print("CURRENT NODE: \(current?.key)")
            current = current?.nextNode
        }
    }
    
    func testBinarySearchTreeLowestValue() {
        
    }
    
    func testLinkedListCreation() {
        // this is a bad test b/c it doesn't really check to see if all the nodes were added
        XCTAssertNotNil(testLinkedList)
    }
    
    func testLinkedListIterativeReverse() {
        
    }
    
    func testLinkedListRecursiveReverse() {
        
    }
}
