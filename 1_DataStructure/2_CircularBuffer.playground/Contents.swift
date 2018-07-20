//: Playground - noun: a place where people can play

import UIKit

example(of: "Circular buffer") {
    var circBuffer = CircularBuffer<Int>(4)
    circBuffer.push(element: 100)
    circBuffer.push(element: 200)
    circBuffer.push(element: 300)
    circBuffer.push(element: 400)
    print(circBuffer)
    
    let x = circBuffer.pop()
    print(x, circBuffer)
    
    let y = circBuffer.peek()
    print(y, circBuffer)
    
    let z = circBuffer.pop()
    print(z, circBuffer)
    
    circBuffer.push(element: 500)
    print(circBuffer)
    circBuffer.push(element: 600)
    print(circBuffer)
    circBuffer.push(element: 700)
    print(circBuffer)
}

