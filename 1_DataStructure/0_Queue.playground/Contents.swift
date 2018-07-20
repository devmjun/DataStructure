//: Playground - noun: a place where people can play

import UIKit

example(of: "Queue") {
    var q1: Queue<Int> = [1,2,3,4,5]
    var q2 = Queue<Int>()
    q1.dequeue()
    print(q1)
    print(q2)
    
    q2.enqueue(element: 55)
    for el in q1 {
        print(el)
    }
    
    q1.clear()
    print(q1)
}


