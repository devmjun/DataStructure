import Foundation

// 초기의 버퍼의 기존 사이즈
private struct Constants {
    fileprivate static let defaultBufferCapacity: Int = 16
}

// 버퍼 연산자를 이야기하는것같음..
public enum CircularBufferOperation {
    case Ignore, Overwrite
}

public struct CircularBuffer<T> {
    fileprivate var data: [T]
    fileprivate var head: Int = 0, tail: Int = 0
    
    private var internalCount: Int = 0
    public var count: Int {
        return internalCount
    }
    
    private var overwriteOperation: CircularBufferOperation = .Overwrite
    
    // 빈 CircularBuffer 구조를 생성
    public init() {
        data = [T]()
        data.reserveCapacity(Constants.defaultBufferCapacity)
    }
    
    // 'count'의 프로퍼티 CircularBuffer를 생성
    // 주의: `count`만큼 2를 거듭제곱하지 않은 경우,
    // 그에 가장 가까운 수만큼 2를 거듭제곱함.
    public init(_ count:Int, overwriteOperation: CircularBufferOperation = .Overwrite){
        var capacity = count
        if (capacity < 1) {
            capacity = Constants.defaultBufferCapacity
        }
        
        // count값보다 큰 2의 제곱을 capacity로 지정
        if ((capacity & (~capacity + 1)) != capacity) {
            var b = 1
            while (b < capacity) {
                b = b << 1
            }
            capacity = b
        }
        
        data = [T]()
        data.reserveCapacity(capacity)
        self.overwriteOperation = overwriteOperation
    }
    
    public init<S: Sequence>(_ elements: S, size: Int) where S.Iterator.Element == T {
        self.init(size)
        //elements.forEach({ push(element: $0)})
    }
    
    // 실제로는 Array의 값을 삭제하는게 아니라, pointer형식으로 head값을 변경해가며 값을 반환
    public mutating func pop() -> T? {
        if isEmpty() {
            return nil
        }
        
        print("head: \(head), tail: \(tail) in pop")
        let el = data[head]
        head = incrementPointer(pointer: head)
        internalCount -= 1
        return el
    }
    
    public func isEmpty() -> Bool {
        return (count < 1)
    }
    
    public func isFull() -> Bool {
        return count == data.capacity
    }
    
    // 증가된 값이 배열의 마지막 요소를 넘을 경우를 대비
    fileprivate func incrementPointer(pointer: Int) -> Int {
        return (pointer + 1) & (data.capacity - 1)
    }
    
    // 감소된 값이 배열의 첫번째 요소에 미치지 못할 경우를 대비
    fileprivate func decrementPointer(pointer: Int) -> Int {
        return (pointer - 1) & (data.capacity - 1)
    }
    
    public func peek() -> T? {
        if isEmpty() {
            return nil
        }
        return data[head]
    }
    
    public mutating func push(element: T) {
        if isFull() {
            switch overwriteOperation {
            case .Ignore: return
            case .Overwrite: pop()
            }
        }
        
        
        if data.endIndex < data.capacity {
            data.append(element)
        }else {
            data[tail] = element
        }
        
        tail = incrementPointer(pointer: tail)
        internalCount += 1
    }
    
    public mutating func clear() {
        head = 0
        tail = 0
        internalCount = 0
        data.removeAll(keepingCapacity: true)
    }
    
    // 버퍼의 용량 반환
    public var capacity: Int {
        get {
            return data.capacity
        }set {
            data.reserveCapacity(newValue)
        }
    }
}

extension CircularBuffer: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        return data.description
    }
    
    public var debugDescription: String {
        return data.debugDescription
    }
}
