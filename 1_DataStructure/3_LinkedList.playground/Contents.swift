//: Playground - noun: a place where people can play

import UIKit

example(of: "Linked List") {
    let node1 = Node<Int>.init(10)
    let node2 = Node<Int>.init(20)
    let node3 = Node<Int>.init(30)
    
    node1.next = node2
    node2.next = node3
    
    print("node1: \(node1) ,\nnode2: \(node2),\nnode3: \(node3)")
}

example(of: "LinkedList") {
    var list = LinkedList<Int>()
    list.push(10)
    list.push(20)
    list.push(30)
    print(list)
    
    let oneNode = list.node(at: 1)!
    print("oneNode: \(oneNode)")
    list.append(1)
    list.append(2)
    list.append(3)
    print(list)
    
    list.insert(-1000, after: oneNode)
    print(list)
    
    list.pop() // 30
    print(list)
    print(list.tail)
    
    list.removeLast()
    print(list)
    
    let no = list.node(at: 3)!
    list.remove(after: no)
    print(list)
}

example(of: "LinkedList conformed Collection Protocol") {
    var list = LinkedList<Int>()
    
    for i in 0..<10 {
        list.append(i)
    }
    
    print(list)
    print(list[list.startIndex])
    print(list.prefix(3))
    print(list.suffix(5))
    print(list.reduce(0, +))
}

example(of: "linked list cow") {
    var list1 = LinkedList<Int>()
    list1.append(1)
    list1.append(2)
    var list2 = list1
    print("List1: \(list1)")
    print("List2: \(list2)")
    print("After appending 3 to list2")
    list2.append(3)
    print("List1: \(list1)")
    print("List2: \(list2)")
    
    print("List1 uniquely referenced: \(isKnownUniquelyReferenced(&list1.head))")
    var list3 = list1
    print("List1 uniquely referenced: \(isKnownUniquelyReferenced(&list1.head))")
}

example(of: "Sharing nodes") {
    var list1 = LinkedList<Int>()
    (1...3).forEach { list1.append($0) }
    var list2 = list1
    print(list1, list2)
    list1.push(100)
    print(list1, list2)
    list2.push(0)
    print(list1, list2)
}
