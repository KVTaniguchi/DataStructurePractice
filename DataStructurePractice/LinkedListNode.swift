//
//  LinkedListNode.swift
//  DataStructurePractice
//
//  Created by Kevin Taniguchi on 1/13/16.
//  Copyright © 2016 Taniguchi. All rights reserved.
//

import Foundation
import UIKit

class LinkedListNode<GenericType> {
    var key: GenericType?
    var nextNode: LinkedListNode?
}

class LinkedList<GenericType: Equatable> {
    private var head = LinkedListNode<GenericType>()
    
    func addNode(key: GenericType) {
        
        if head.key == nil {
            head.key = key
            return
        }
        
        var current: LinkedListNode? = head
        
        while current != nil {
            if current?.nextNode != nil {
                let childNode: LinkedListNode = LinkedListNode<GenericType>()
                childNode.key = key
                current?.nextNode = childNode
                break
            }
            
            current = current?.nextNode
        }
    }
    
    func reverse() -> LinkedList{
        var previousNode: LinkedListNode<GenericType>?
        var nextNodeToReverse: LinkedListNode<GenericType>?
        var currentNode: LinkedListNode<GenericType>?
        
        if head.nextNode == nil {
            return self
        }
        
        // make the head the tail
        
        currentNode = head.nextNode                     // current node is B
        head.nextNode = nil                             // head is made to tail
        nextNodeToReverse = currentNode?.nextNode       // next node is C
        currentNode?.nextNode = head                    // B points at A
        
        // next node is C
        // current node is B
        
        while nextNodeToReverse?.nextNode != nil {
            previousNode = currentNode                  // prev is now C
            currentNode = nextNodeToReverse             // current is now D
            currentNode?.nextNode = previousNode        // D points at C
            nextNodeToReverse = currentNode?.nextNode   // next node is E
        }
        
        return LinkedList()
        
        // prev is B
        // current is C
        // C points at B
        // next node is D
    }
    
    func recursiveReverse(currentNode: LinkedListNode<GenericType>?) {
        guard let current = currentNode else { return }
        
        if currentNode?.nextNode == nil {
            guard let node = currentNode else { return }
            head = node
            return
        }
        
        recursiveReverse(current.nextNode!)
        current.nextNode?.nextNode = current
        current.nextNode = nil
    }
}

// A -> B -> C -> D -> E

