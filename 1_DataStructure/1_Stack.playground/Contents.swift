//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
example(of: "Stack") {
    
    var myStack = ArrayStack<Int>()
    
    myStack.push(element: 5)
    myStack.push(element: 44)
    myStack.push(element: 23)
    
    print(myStack)
    
    var x = myStack.pop()
    x = myStack.pop()
    
    x = myStack.pop()
    x = myStack.pop()
    x = myStack.pop()
    
    print(myStack)
    
    myStack.push(element: 87)
    myStack.push(element: 2)
    myStack.push(element: 9)
    
    print(myStack)
    print(type(of: myStack))
    
    for i in myStack {
        print(i)
    }
    print("my stack is: \(myStack)")
}
