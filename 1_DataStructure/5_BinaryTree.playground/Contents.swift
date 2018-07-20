//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

example(of: "BinarySearch") {
    print(tree)
}

example(of: "in-order traversal") {
    tree.traverseInOrder { print($0) }
}

example(of: "pre-order traversal") {
    tree.traversePreOrder { print($0) }
}

example(of: "post-order traversal") {
    tree.traversePostOrder { print($0) }
}


