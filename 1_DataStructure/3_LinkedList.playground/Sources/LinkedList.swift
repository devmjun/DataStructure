import Foundation

// Linked List: 늘어선 Node 들을 관리하는 하나의 자료구조
public struct LinkedList<Value> {
    public var head: Node<Value>?
    public var tail: Node<Value>?
    
    public init() {}
    public var isEmpty: Bool {
        return head == nil
    }
    
    public mutating func push(_ value: Value) {
        copyNodes()
        // 현재의 head에 새로운 node를 삽입하고, head의 next를 기존에 head에 있던 값을 지정
        head = Node.init(value, next: head)
        
        // 맨 처음 값을 넣은 케이스임, head, tail이 같은 곳을 가리키고 있음
        if tail == nil {
            tail = head
        }
    }
    
    public mutating func append(_ value: Value) {
        copyNodes()
        // 만약 비어있다면, 새롭게 추가된 값이 head, tail이 가르켜 주어야 하기때문에, push랑 같은 방식임. 그래서 push 호출
        guard !isEmpty else {
            push(value)
            return
        }
        /* guard문 이후라, forced casting
         현재의 tail의 Next 값에 새로운 값을 추가하고, tail을 새롭게 추가된 값으로 다시 참조 합니다.
         */
        tail!.next = Node.init(value)
        // 3
        tail = tail!.next
    }
    
    /**
     특정 위치의 Node를 찾기위한 method
     Node들의 Index 값을 넣으면, 해당 인덱스에 값이 있는지 없는지를 확인후, Node를 반환함.
     */
    public func node(at index: Int) -> Node<Value>? {
        // 1: head와 현재 Index
        var currentNode = head
        var currentIndex = 0
        
        // 2: 현재 노드에서부터, 다음 노드를 순회하며, 대상 Node의 Index에 어떤 값이 있는지확인.. LikedList가 자료의 추가 삭제 성능이 Array보다 좋은대신 특정 대상에 접근하는건 역시 좋지않음..(=모든 노드들을 순회해야하니..흐)
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode!.next
            currentIndex += 1
        }
        return currentNode
    }
    
    /**
     LikedList내부에 있는 Node와 값을 넣으면, 해당 노드 뒤에 값을 추가함..
     */
    @discardableResult
    public mutating func insert(_ value: Value, after node: Node<Value>) -> Node<Value> {
        copyNodes()
        guard tail !== node else {
            append(value)
            return tail!
        }
        node.next = Node(value, next: node.next)
        return node.next!
    }
    
    /*
     head를 가리키고 있는 포인터를 next로 이동시킴. 이때 head, tail이 같은 node를 가르키고 있는경우(Node가 1개)에는 head와 tail 모두 nil로 만들어줌
     */
    @discardableResult
    public mutating func pop() -> Value? {
        //        defer {
        //            head = head?.next
        //            if isEmpty {
        //                tail = nil }
        //        }
        
        guard head != nil else { return nil }
        head = head?.next
        if isEmpty {
            tail = nil
        }
        
        return head?.value
    }
    
    /*-------------Remove--------------*/
    public mutating func removeLast() -> Value? {
        /*
         1. head가 nil이 아니어야 하고, Node가 1개이면, pop 호출함.
         */
        guard let head = head else { return nil }
        guard head.next != nil else { return pop() }
        
        var prev = head
        var current = head
        
        // head에서 출발해서 현재값, 다음값을 차례로 가져와서 마지막 next값을 nil로 만들고, tail을 next이전 값으로 가리키고, 지운값을 반환함.. 여기서 필요한 지식은 Reference Type sementics
        while let next = current.next {
            print("next: \(next),\nprev: \(prev),\ncurrent: \(current)")
            prev = current
            current = next
        }
        
        prev.next = nil
        tail = prev
        return current.value
    }
    
    @discardableResult
    /*
     예제들에서 defer문들이 많이 사용되었는데, 함수의 스코프 종류 이후에 실행을 보장하기 위해서 사용한것같음... 아니면 레퍼런스 카운팅을 명시적으로 관리하려고하는것인가.. 정확한 의도는 잘 모르겠내 ㅠ.ㅠ
     
     집어넣은 노드 다음의 값을 삭제함.
     */
    public mutating func remove(after node: Node<Value>) -> Value? {
        //        defer {
        //            if node.next === tail {
        //                tail = node }
        //            node.next = node.next?.next
        //        }
        
        if node.next === tail { tail = node }
        node.next = node.next?.next
        return node.next?.value
    }
    
    /*
     Value sementic and copy-on-write
     */
    private mutating func copyNodes() {
        // 객체의 참조가 1개인지, 1개 이상인지 여부를 확인할수 있음.
        guard !isKnownUniquelyReferenced(&head) else {return}
        guard var oldNode = head else {
            return
        }
        // Node를 추가, 삭제할때 마다, 기존의 Node들을 새롭게 할당함.. Copy-on-Write..
        head = Node(oldNode.value)
        var newNode = head
        while let nextOldNode = oldNode.next {
            newNode!.next = Node(nextOldNode.value)
            newNode = newNode!.next
            oldNode = nextOldNode
        }
        tail = newNode
    }
    
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        guard let head = head else {
            return "Empty list"
        }
        return String(describing: head)
    }
}




/*-----------------Using Collection Porotocol *----------------------*/


//extension LinkedList: Collection {
//    public struct Index: Comparable {
//        public var node: Node<Value>?
//
//        static public func ==(lhs: Index, rhs: Index) -> Bool {
//            switch (lhs.node, rhs.node) {
//            case let (left?, right?):
//                return left.next === right.next
//            case (nil, nil):
//                return true
//            default:
//                return false
//            }
//        }
//
//        static public func <(lhs: Index, rhs: Index) -> Bool {
//            // 두값이 같지 않다로 시작.
//            guard lhs != rhs else {
//                return false
//            }
//
//            let nodes = sequence(first: lhs.node) { $0?.next }
//            return nodes.contains { $0 === rhs.node }
//        }
//    }
//}

extension LinkedList: Collection {
    public struct Index: Comparable {
        public var node: Node<Value>?
        static public func ==(lhs: Index, rhs: Index) -> Bool {
            switch (lhs.node, rhs.node) {
            case let (left?, right?):
                return left.next === right.next
            case (nil, nil):
                return true
            default:
                return false
            } }
        static public func <(lhs: Index, rhs: Index) -> Bool {
            guard lhs != rhs else {
                return false
            }
            let nodes = sequence(first: lhs.node) { $0?.next }
            return nodes.contains { $0 === rhs.node }
        }
    }
    
    // 1
    public var startIndex: Index {
        return Index(node: head)
    }
    // 2
    public var endIndex: Index {
        return Index(node: tail?.next)
    }
    
    public func index(after i: Index) -> Index {
        return Index(node: i.node?.next)
    }
    // 4
    public subscript(position: Index) -> Value {
        return position.node!.value
    }
}
