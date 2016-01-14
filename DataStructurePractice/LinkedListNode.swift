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
}

