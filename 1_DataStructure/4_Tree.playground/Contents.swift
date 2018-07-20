//: Playground - noun: a place where people can play

import UIKit


example(of: "BinaryTree") {
    let beverages = TreeNode("Beverages")
    let hot = TreeNode("Hot")
    let cold = TreeNode("Cold")
    
    beverages.add(hot)
    beverages.add(cold)
    
    print(beverages)
    
}

example(of: "BinaryTree depth-first-traversal") {
    let tree = makeBeverageTree()
    tree.forEachDepthFirst { print($0.value) }
}

example(of: "Lever-order traversal") {
    let tree = makeBeverageTree()
    tree.forEachLevelOrder { print($0.value) }
    
}

example(of: "searching for a node") {
    // tree from last example
    let tree = makeBeverageTree()
    if let searchResult1 = tree.search("ginger ale") {
        print("Found node: \(searchResult1.value)")
    }
    if let searchResult2 = tree.search("WKD Blue") {
        print(searchResult2.value)
    } else {
        print("Couldn't find WKD Blue")
    }
}

