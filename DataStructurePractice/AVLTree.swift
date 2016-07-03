//
//  AVLTree.swift
//  DataStructurePractice
//
//  Created by Kevin Taniguchi on 7/3/16.
//  Copyright © 2016 Taniguchi. All rights reserved.
//

import Foundation

protocol BinarySearchTreeType {
    associatedtype Element
    mutating func insert(element: Element)
    mutating func find(element: Element) -> Element?
}


class Node<Element: Comparable> {
    var value: Element
    var leftNode: Node?
    var rightNode: Node?
    
    init(value: Element) {
        self.value = value
    }
    
    var height: Int {
        let left = leftNode != nil ? leftNode!.height + 1 : 0
        let right = rightNode != nil ? rightNode!.height + 1: 0
        
        
        
        
        return max(left, right)
    }
}

enum BinarySearchTreeError: ErrorType {
    case OutOfBound
}

final class BinarySearchTree<Element: Comparable>: BinarySearchTreeType {
    
    private var _root: Node<Element>?
    private var _count: Int = 0
    
    var root: Node<Element>? {
        return _root
    }
    var count: Int {
        return _count
    }
    
    /**
     Inserts an element into the AVL tree. Duplicate elements are ignored.
     - parameter element: Element which will be added to the tree.
     It must conform to Comparable.
     */
    func insert (element: Element) {
        if let _ = _root {
            self.insert(element, currentNode: &_root!)
        } else {
            _root = Node(value: element)
            _count += 1
        }
    }
    
    private func insert(element: Element, inout currentNode: Node<Element>) -> Node<Element> {
        if currentNode.value > element {
            if currentNode.leftNode != nil {
                currentNode.leftNode = insert(element, currentNode: &currentNode.leftNode!)
            } else {
                currentNode.leftNode = Node<Element>(value: element)
                _count += 1
            }
            if height(currentNode.leftNode) - height(currentNode.rightNode) == 2 {
                if element < currentNode.leftNode!.value {
                    currentNode = rightRotate(currentNode)
                } else {
                    currentNode.leftNode = leftRotate(currentNode.leftNode!)
                    currentNode = rightRotate(currentNode)
                }
            }
        } else if currentNode.value < element {
            if currentNode.rightNode != nil {
                currentNode.rightNode = insert(element, currentNode: &currentNode.rightNode!)
            } else {
                currentNode.rightNode = Node<Element>(value: element)
                _count += 1
            }
            
            if height(currentNode.rightNode) - height(currentNode.leftNode) == 2 {
                if element > currentNode.rightNode!.value {
                    currentNode = leftRotate(currentNode)
                } else {
                    currentNode.rightNode = rightRotate(currentNode.rightNode!)
                    currentNode = leftRotate(currentNode)
                }
            }
        }
        return currentNode
    }
    
    private func balance(node: Node<Element>?) -> Int {
        if let node = node {
            return height(node.leftNode) - height(node.rightNode)
        }
        return 0
    }
    
    private func height (node: Node<Element>?) -> Int {
        return node != nil ? node!.height : -1
    }
    
    private func leftRotate(node: Node<Element>) -> Node<Element> {
        let newRoot = node.rightNode!
        let oldRootRight = newRoot.leftNode
        node.rightNode = oldRootRight
        newRoot.leftNode = node
        return newRoot
    }
    
    private func rightRotate(node: Node<Element>) -> Node<Element> {
        let newRoot = node.leftNode!
        let oldRootLeft = newRoot.rightNode
        node.leftNode = oldRootLeft
        newRoot.rightNode = node
        return newRoot
    }
    
    /**
     Returns element with the smallest value in the tree.
     - parameter root: Root node for the tree.
     - returns: Node with the smallest value
     */
    func minNode (root: Node<Element>) -> Node<Element> {
        var _current = root
        while _current.leftNode != nil {
            _current = _current.leftNode!
        }
        return _current
    }
    
    /**
     Returns element with the largest value in the tree.
     - parameter root: Root node for the tree.
     - returns: Node with the largest value
     */
    func maxNode(root: Node<Element>) -> Node<Element> {
        var _current = root
        while _current.rightNode != nil {
            _current = _current.rightNode!
        }
        return _current
    }
    /**
     Returns the predecessor element of a given element according to in-order traversal of the tree.
     - parameter node: Node from which want the predecessor.
     - returns: Predecessor for the node passed as a parameter
     */
    func predecessor(node: Node<Element>) -> Node<Element>? {
        if let root = _root {
            return self.predecessor(node, root: root)
        }
        return nil
    }
    
    private func predecessor(node: Node<Element>, root: Node<Element>) -> Node<Element>? {
        if let leftSubTree = node.leftNode {
            return maxNode(leftSubTree)
        }
        
        var _current: Node<Element>? = root
        var result: Node<Element>?
        while _current != nil {
            if _current!.value > node.value {
                _current = _current?.leftNode
            } else if _current!.value < node.value {
                result = _current
                _current = _current!.rightNode
            } else {
                return result
            }
        }
        return result
    }
    
    /**
     Returns the successor element of a given element according to in-order traversal of the tree.
     - parameter node: Node from which we want the successor.
     - returns: Predecessor for the node passed as a parameter
     */
    func successor(node: Node<Element>) -> Node<Element>? {
        if let root = _root {
            return successor(node, root: root)
        }
        return nil
    }
    
    private func successor(node: Node<Element>, root: Node<Element>) -> Node<Element>? {
        if let righSubTree = node.rightNode {
            return minNode(righSubTree)
        }
        
        var _current: Node<Element>? = root
        var result: Node<Element>?
        
        while _current != nil {
            if node.value < _current!.value {
                result = _current
                _current = _current?.leftNode
            } else if node.value > _current!.value {
                _current = _current?.rightNode
            } else {
                return result
            }
        }
        return result
    }
    /**
     Finds an element in the AVL tree. Since the tree is self-balancing,
     this lookup will always be a O(lg n) operation.
     
     - parameter element: Element we want to find in the tree
     - returns: Element if it is found, nil otherwise.
     */
    func find(element: Element) -> Element? {
        if let node = self.findNode(element) {
            return node.value
        }
        return nil
    }
    /**
     Finds the node for an element in the AVL tree. Since the tree
     is self-balancing, this lookup will always be a O(lg n) operation.
     
     - parameter element: Element we want to find in the tree
     - returns: Node of the element if it is found, nil otherwise.
     */
    
    func findNode(element: Element) -> Node<Element>? {
        return findNode(element, node: _root)
    }
    
    private func findNode(element: Element, node: Node<Element>?) -> Node<Element>? {
        if let node = node {
            if node.value == element {
                return node
            } else if node.value > element {
                return findNode(element, node: node.leftNode)
            } else if node.value < element {
                return findNode(element, node: node.rightNode)
            }
        }
        return nil
    }
}

extension BinarySearchTree: SequenceType {
    
    func generate() -> AnyGenerator<Element> {
        var _current: Node<Element>?
        return AnyGenerator {
            if _current != nil {
                _current = self.successor(_current!)
            } else {
                if self.root != nil {
                    _current = self.minNode(self.root!)
                }
            }
            return _current != nil ? _current?.value : nil
        }
    }
}

extension BinarySearchTree: CollectionType {
    
    var startIndex: Int {
        return 0
    }
    
    var endIndex: Int {
        return count
    }
    
    subscript(index: Int) -> Element {
        return self.findItemAtIndexUnsafe(index).value
    }
    
    private func findItemAtIndexUnsafe(index: Int) -> Node<Element> {
        var currentCount = index
        var result: Node<Element>?
        findItemAtIndex(&currentCount, node: root!, result: &result)
        return result!
    }
    
    func findItemAtIndex(inout index: Int, node: Node<Element>, inout result: Node<Element>?) {
        
        if node.leftNode != nil {
            findItemAtIndex(&index, node: node.leftNode!, result: &result)
        }
        
        if index == 0 {
            result = node
        }
        index -= 1
        
        if node.rightNode != nil {
            findItemAtIndex(&index, node: node.rightNode!, result: &result)
        }
    }
    
    func findItemAtIndex(index: Int) throws -> Node<Element> {
        if let root = root {
            var index = index
            var result: Node<Element>?
            findItemAtIndex(&index, node: root, result: &result)
            if let result = result {
                return result
            }
        }
        throw BinarySearchTreeError.OutOfBound
    }
}

extension BinarySearchTree: ArrayLiteralConvertible {
    convenience init(arrayLiteral: Element...) {
        self.init()
        for element in arrayLiteral {
            self.insert(element)
        }
    }
}

