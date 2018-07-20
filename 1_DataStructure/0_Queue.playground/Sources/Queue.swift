import Foundation

/*
 큐를 만들때 필요한것
 1. enqueue: 맨뒤에 새로운 요소 추가
 2. dequeue: 맨 앞의 값 제거 한뒤 반환
 3. peek: 큐의 첫번재 오ㅛ소를 반환하되 제거하지 않음
 4. clear: 큐를 재설정해 빈 상태가 되게함
 5. count: 큐에 있는 요소의 수르 반환
 6. isEmpty: 큐가 비어있으면 true 반환, 그렇지 않은 경우 false반환
 7. isFull = 큐가 꽉차있으면 true반환 ,그렇지 않은 경우 false반환
 8. capacity 큐 용량 을 가져오거나 설정을 위한 read/write 프로퍼티
 9. insert(_atIndex)큐의 특정 인덱스 위치에 요소를 삽입
 10. removeAtIndeX(): 큐의 특정 위치에 있는 요소를 제거
 */
public struct Queue<T> {
    public var data: [T] = [T]()
    public init() {}
    
    public init<S: Sequence>(_ elements: S) where S.Iterator.Element == T  {
        data.append(contentsOf: elements)
    }
    
    public mutating func enqueue(element: T)  {
        data.append(element)
    }
    
    public mutating func dequeue() -> T? {
        return data.removeFirst()
    }
    
    public mutating func peek() -> T? {
        return data.first
    }
    
    public mutating func clear() {
        data.removeAll()
    }
    
    public var count: Int {
        return data.count
    }
    
    public var capacity: Int {
        get {
            return data.capacity
        }set {
            return data.reserveCapacity(newValue)
        }
    }
    
    public var isFull: Bool {
        return data.capacity == data.count
    }
    
    public var isEmpty: Bool {
        return data.isEmpty
    }
}

extension Queue: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        return self.data.description
    }
    
    public var debugDescription: String {
        return self.data.debugDescription
    }
}

extension Queue: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: T...) {
        data = elements
    }
}

extension Queue: Sequence {
    public func makeIterator() -> AnyIterator<T> {
        return AnyIterator(IndexingIterator(_elements: data.lazy))
    }
}
