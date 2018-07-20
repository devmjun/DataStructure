//: Playground - noun: a place where people can play

import UIKit
var exampleTree: BinarySearchTree<Int> = {
        var bst = BinarySearchTree<Int>()
        bst.insert(50)
        bst.insert(25)
        bst.insert(12)
        bst.insert(37)
        bst.insert(10)
        bst.insert(17)
        bst.insert(32)
        bst.insert(45)
        bst.insert(27)
        bst.insert(33)
        bst.insert(63)
        bst.insert(87)
        return bst
}()

example(of: "unbalenced building a BST") {
    var bst = BinarySearchTree<Int>()
    for i in 0..<5 {
        bst.insert(i)
    }
    print(bst)
}

example(of: "balenced building a BST") {
    print(exampleTree)
}

example(of: "finding a node") {
    if exampleTree.contains(5) {
        print("Found 5!")
    } else {
        print("Couldn't find 5")
    }
}

example(of: "Iterator Test") {
    var bst = BinarySearchTree<Int>()
    
    bst.insert(10)
    bst.insert(20)
    bst.insert(30)
    
    bst.insert(10)
    bst.insert(20)
    bst.insert(30)
    debugPrint(bst)
}

example(of: "COW(Copy On Wirte)") {
    var bst: BinarySearchTree<Int> {
        var b = BinarySearchTree<Int>.init()
        b.insert(30)
        b.insert(10)
        b.insert(20)
        return b
    }
    
    var bst1 = bst
    
    bst1.insert(-1000)
    
    debugPrint(bst)
    debugPrint(bst1)
    
    var bst2 = bst1
    bst2.insert(2000)
    
    // Copy on Wirte가 이상하게 작동함..
    debugPrint(bst)
    debugPrint(bst1)
    debugPrint(bst2)
}

example(of: "Remove") {
    exampleTree.remove(25)
    debugPrint(exampleTree)
}


/*------------------------On Class----------------------------*/

example(of: "tree", isAction: false) {
    let rootOfTree = BinaryTreeNode.init(value: 1)
    rootOfTree.leftChild = BinaryTreeNode.init(value: 2, left: nil, right: nil, parent: rootOfTree)
    print(rootOfTree)
}

example(of: "addNode", isAction: false) {
    let root = BinaryTreeNode(value: 10)
    
    root.insertNodeFromRoot(value: 20)
    root.insertNodeFromRoot(value: 30)
    root.insertNodeFromRoot(value: 40)
    root.insertNodeFromRoot(value: 50)
    root.insertNodeFromRoot(value: 60)
    root.insertNodeFromRoot(value: 70)
    root.insertNodeFromRoot(value: 80)
    
    // 트리 저장 나쁜예 ㅠㅠ
    print("""
        root: \(root)
        root.right: \(root.rightChild)
        root.right.right: \(root.rightChild?.rightChild)
        root.right.right.right: \(root.rightChild?.rightChild?.rightChild)
        """)
    
    // 일반
    let root1 = BinaryTreeNode(value: 10)
    root1.insertNodeFromRoot(value: 20)
    root1.insertNodeFromRoot(value: 5)
    root1.insertNodeFromRoot(value: 21)
    root1.insertNodeFromRoot(value: 8)
    root1.insertNodeFromRoot(value: 4)
    
    print("""
        \n
        root: \(root1)
        root.right: \(root1.rightChild)
        root.left: \(root1.leftChild)
        root.right.right: \(root1.rightChild?.rightChild)
        root.right.left: \(root1.rightChild?.leftChild)
        """)
}

example(of: "traverseInOrder", isAction:  false) {
    let root = BinaryTreeNode(value: 10)
    root.insertNodeFromRoot(value: 20)
    root.insertNodeFromRoot(value: 5)
    root.insertNodeFromRoot(value: 21)
    root.insertNodeFromRoot(value: 8)
    root.insertNodeFromRoot(value: 4)
    BinaryTreeNode.traverseInOrder(node: root)
}

example(of: "traversePreOrder", isAction: false) {
    let root = BinaryTreeNode(value: 10)
    root.insertNodeFromRoot(value: 20)
    root.insertNodeFromRoot(value: 5)
    root.insertNodeFromRoot(value: 21)
    root.insertNodeFromRoot(value: 8)
    root.insertNodeFromRoot(value: 4)
    BinaryTreeNode.traversePreOrder(node: root)
}

example(of: "traversePostOrder", isAction: false) {
    let root = BinaryTreeNode(value: 10)
    root.insertNodeFromRoot(value: 20)
    root.insertNodeFromRoot(value: 5)
    root.insertNodeFromRoot(value: 21)
    root.insertNodeFromRoot(value: 8)
    root.insertNodeFromRoot(value: 4)
    BinaryTreeNode.traversePostOrder(node: root)
}

example(of: "search") {
    let root = BinaryTreeNode(value: 10)
    root.insertNodeFromRoot(value: 20)
    root.insertNodeFromRoot(value: 5)
    root.insertNodeFromRoot(value: 21)
    root.insertNodeFromRoot(value: 8)
    root.insertNodeFromRoot(value: 4)
    print(root.search(value: 4)?.value)
    print(root.search(value: 100)?.value)
}

example(of: "Delete") {
    let root = BinaryTreeNode(value: 10)
    root.insertNodeFromRoot(value: 20)
    root.insertNodeFromRoot(value: 5)
    root.insertNodeFromRoot(value: 21)
    root.insertNodeFromRoot(value: 300)
    root.insertNodeFromRoot(value: 8)
    root.insertNodeFromRoot(value: 4)
    
    root.delete()
}

example(of: "Delete1") {
    let root = BinaryTreeNode(value: 10)
    root.insertNodeFromRoot(value: 20)
    root.insertNodeFromRoot(value: 5)
    root.insertNodeFromRoot(value: 21)
    root.insertNodeFromRoot(value: 300)
    root.insertNodeFromRoot(value: 8)
    root.insertNodeFromRoot(value: 4)
    
    BinaryTreeNode.traverseInOrder(node: root)
    root.leftChild?.delete()
    
    BinaryTreeNode.traverseInOrder(node: root)
}

example(of: "Delete2") {
    let root = BinaryTreeNode(value: 20)
    root.insertNodeFromRoot(value: 17)
    root.insertNodeFromRoot(value: 30)
    root.insertNodeFromRoot(value: 10)
    root.insertNodeFromRoot(value: 19)
    root.insertNodeFromRoot(value: 25)
    root.insertNodeFromRoot(value: 40)
    root.insertNodeFromRoot(value: 22)
    root.insertNodeFromRoot(value: 27)
    root.insertNodeFromRoot(value: 35)
    root.insertNodeFromRoot(value: 50)
    BinaryTreeNode.traverseInOrder(node: root)
    
    // 자식노드가 2개인 경우 삭제 -> 30 삭제
    root.rightChild?.delete()
    print("root.right: \(root.rightChild),\nroot.leftChiled: \(root.leftChild)\n")
    print("root.right.left: \(root.rightChild?.leftChild)\n")
    print("root.right.right: \(root.rightChild?.rightChild)")
    
    // 자식 노드가 1개인 경우 삭제 -> 40 삭제
    root.rightChild?.rightChild?.delete()
    print(root.rightChild?.rightChild)
    BinaryTreeNode.traverseInOrder(node: root)
    
    // 자식 노드가 0개인 경우 삭제
    root.leftChild?.leftChild?.delete()
    print(root.leftChild)
    
    // 노드의 높이와 깊이.
    print("\nheight of root: \(root.height()), depth of Node: \(root.rightChild?.rightChild?.rightChild?.depth())")
}

example(of: "Iterator Test") {
    var root = BinaryTreeNode(value: 10)
    root.insertNodeFromRoot(value: 20)
    root.insertNodeFromRoot(value: 30)
    
    root.insertNodeFromRoot(value: 10)
    root.insertNodeFromRoot(value: 20)
    root.insertNodeFromRoot(value: 30)
    
    debugPrint(root)
}

