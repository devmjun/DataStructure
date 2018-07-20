import Foundation

// 우선순위 큐를 Heap을 사용하여 구현합니다.
public struct PriorityQueue<Element: Equatable>: Queue { // 1
    private var heap: Heap<Element> // 2
    public init(sort: @escaping (Element, Element) -> Bool,
         elements: [Element] = []) { // 3
        heap = Heap(sort: sort, elements: elements)
    }
    
    public var isEmpty: Bool { return heap.isEmpty }
    public var peek: Element? { return heap.peek() }
    
    public mutating func enqueue(_ element: Element) -> Bool { // 1
        heap.insert(element)
        return true
    }
    public mutating func dequeue() -> Element? { // 2
        return heap.remove()
    }
}
