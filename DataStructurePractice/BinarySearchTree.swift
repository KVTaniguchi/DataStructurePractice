//
//  BinarySearchTree.swift
//  DataStructurePractice
//
//  Created by Kevin Taniguchi on 1/19/16.
//  Copyright © 2016 Taniguchi. All rights reserved.
//

import Foundation

public class BSTree<T: Comparable> {
    var key: T?
    var left: BSTree?
    var right: BSTree?
    
    // to make this bi-directional add
    // var previousLeft: BSTree?
    // var previousRight: BSTree?
    
    init() {
    }
    
    func addNode(addedKey: T) {
        if key == nil {
            key = addedKey
            return
        }
        
        if addedKey < key {
            if left == nil {
                let newLeftNode = BSTree()
                newLeftNode.key = addedKey
                left = newLeftNode
            }
            else {
                guard let currentLeft = left else { return }
                currentLeft.addNode(addedKey)
            }
        }
        
        if addedKey > self.key {
            if right == nil {
                let newRightNode = BSTree()
                newRightNode.key = addedKey
                right = newRightNode
            }
            else {
                guard let currentRight = right else { return }
                currentRight.addNode(addedKey)
            }
        }
    }
    
//    func findHeadFromKey(key: T) -> BSTree? {
//        
//    }
    
    func lowestValueNodeFrom(node: BSTree?) -> BSTree? {
        if left == nil && right == nil {
            return self
        }
        
        if let leftKey = left where leftKey.key < key {
            return lowestValueNodeFrom(node)
        }
        if let rightKey = right where rightKey.key < key {
            return lowestValueNodeFrom(node)
        }
        return nil
    }
    
//    func highestValueNode() -> BSTree? {
//        
//    }
}

