import Foundation

public struct ArrayStack<T> {
    fileprivate var elements = [T]()
    public init() {}
    
    // 초기화시 Stack의 내부 요소들의 타입은 <T>
    public init<S : Sequence>(_ s: S) where S.Iterator.Element == T {
        self.elements = Array(s.reversed())
    }
    
    // 마지막 요소를 삭제하고 꺼낸값을 반환
    mutating public func pop() -> T? {
        return self.elements.popLast()
        
    }
    
    mutating public func push(element: T){
        self.elements.append(element)
    }
    
    // 마지막 요소를 삭제하지 않고 반환
    public func peek() -> T? {
        return self.elements.last
    }
    
    public func isEmpty() -> Bool {
        return self.elements.isEmpty
    }
    
    public var count: Int {
        return self.elements.count
    }
}

/*
 var stack: ArrayStack<String> = ["1","2"...]
 리터럴 문법이 가능
 */
extension ArrayStack: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = T
    public init(arrayLiteral elements: T...) {
        self.elements = elements
    }
}



/*
 ArrayStack<String>(elements: []) ArrayStack<Int>(elements: [1, 2, 3, 4, 5]) -> [] [1, 2, 3, 4, 5]
 프린트시 요소들만 볼수있음. 혹은, 다른것으로 변경 가능
 */
extension ArrayStack: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        return self.elements.description
    }
    
    public var debugDescription: String {
        return self.elements.debugDescription
    }
}

// 1번 방법
//extension ArrayStack: Sequence {
//
//    public func makeIterator() -> AnyIterator<T> {
//        return AnyIterator(IndexingIterator(_elements: self.elements.lazy.reversed()))
//    }
//}

// 2번 방법
//extension ArrayStack: Sequence, IteratorProtocol {
//    public mutating func next() -> T? {
//        return self.elements.count < 0 ? nil : self.elements.popLast()
//    }
//}

// 3번 방법 = 동작하지 않는데 이유가 뭐지..
//struct ArrayIterator<T>: IteratorProtocol {
//    var currentElement: [T]
//    init(elements: [T]) {
//        self.currentElement = elements
//    }
//
//    mutating func next() -> T? {
//        if !(self.currentElement.isEmpty) {
//            return self.currentElement.popLast()
//        }
//        return nil
//    }
//}
//
//extension ArrayStack: Sequence {
//    func makeIterator() -> ArrayIterator<T> {
//        return ArrayIterator<T>(elements: self.elements)
//    }
//}

// 4번 방법
extension ArrayStack: Sequence {
    public func makeIterator() -> AnyIterator<T> {
        return AnyIterator(IndexingIterator(_elements: self.elements.lazy.reversed()))
    }
}
