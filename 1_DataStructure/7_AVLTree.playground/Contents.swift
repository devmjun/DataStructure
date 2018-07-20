import Foundation

example(of: "Insert AVL Node") {
    
    var tree = AVLTree<Int>()
    for i in 0..<15 {
        tree.insert(i)
    }
    print(tree)
    tree.root?.traverseInOrder{ print($0) }
    
}

example(of: "Remove AVL Node ") {
    var tree = AVLTree<Int>()
    tree.insert(15)
    tree.insert(10)
    tree.insert(16)
    tree.insert(18)
    print(tree)
    tree.remove(10)
    print(tree)
}

