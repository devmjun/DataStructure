import Foundation

public struct Heap<Element: Equatable> {
    public var elements: [Element] = []
    
    // 2개의 요소를 받아서, Bool 값을 반환하는 클로져
    public let sort: (Element, Element) -> Bool
    public init(sort: @escaping (Element, Element) -> Bool, elements: [Element] = []) {
        self.sort = sort
        self.elements = elements
        if !elements.isEmpty {
            
            // 부모 노드의 수만큼 횟수로 sift down은 해주면, 해당 부모들만큼 Heap의 규칙이 초기화됨.(= 부모는 자식보다 큰값)
            for i in stride(from: elements.count / 2 - 1, through: 0, by: -1) {
                print("초기화의 i:\(i)")
                siftDown(from: i)
            }
        }
        print("-----------초기화 종료---------")
    }
    
    public var isEmpty: Bool { return elements.isEmpty }
    public var count: Int { return elements.count }
    public func peek() -> Element? { return elements.first }
    
    // 수식을 통해서 배열의 좌, 우를 가르켜서 사용함.
    func leftChildIndex(ofParentAt index: Int) -> Int { return (2 * index) + 1 }
    func rightChildIndex(ofParentAt index: Int) -> Int { return (2 * index) + 2 }
    func parentIndex(ofChildAt index: Int) -> Int { return (index - 1) / 2 }
    
    /**
     1. elements가 비어있는지 아닌지 확인
     2. Heap의 Root과 맨 마지막 값을 스왑.
     3. siftDwon 실행
     4. 배열의 마지막 요소 삭제후, 삭제값 반환
     */
    public mutating func remove() -> Element? {
        // 1. elements가 비어있으면 함수 종료
        guard !isEmpty else { return nil }
        
        // 2. 첫번째 인덱스의 값과, 맨 마지막 인덱스의 값을 변경
        print(" 요소들: \(elements) 스왑 전")
        elements.swapAt(0, count - 1)
        print(" 요소들: \(elements) 스왑 후")
        
        
        // 4
        defer {
            print("siftDown 호출 \n")
            siftDown(from: 0)
        }
        
        // 3. 배열의 마지막 요소를 지우고, 지운값을 반환함.
        return elements.removeLast()
    }
    
    /**
     from 값은 0으로 호출, 현재 0은 Heap의 마지막값으로 스왑된 상태
     */
    public mutating func siftDown(from index: Int) {
        // 1
        var parent = index
        print("index: \(index), parent: \(parent), elements: \(elements) ")
        // 2
        while true {
            print("반복문 속의 elements: \(elements)")
            // 3: 부모의 왼쪽, 오른쪽 자식의 인덱스값 반환
            let left = leftChildIndex(ofParentAt: parent)
            let right = rightChildIndex(ofParentAt: parent)
            print("left: \(left), right: \(right)")
            // 4: 지원자에 부모 인덱스 할당
            var candidate = parent
            
            /*
             왼쪽 자식의 인덱스가, 배열의 인덱스보다 작으면서(참, 거짓) && 왼쪽 요소가 오른쪽 요소 보다 작으면(참, 거짓) candidate 에 왼쪽 인덱스 할당
             >: 오름차순 -> 10 9 8...
             <: 내림차순 -> 1 2 3...
             
             왼쪽 혹은 오른쪽 자식이 둘다 크거나 작지 않으면(=해당 조건에 맞으면) 반복문 종료
             */
            //            print(elements, parent, index, left, right)
            if left < count && sort(elements[left], elements[candidate]) {
                print("left < count && sort(elements[left], elements[candidate]): \(elements[left], elements[candidate])")
                candidate = left
            }
            // 6
            if right < count && sort(elements[right], elements[candidate]) {
                print("right < count && sort(elements[right], elements[candidate]): \(elements[right], elements[candidate])")
                candidate = right
                
            }
            print("candidate: \(candidate), parent:\(parent)")
            if candidate == parent { return }
            
            // 8
            /*
             계속 선별하면서, 부모와 자식들간의 값 중 크거나, 혹은 작은 값이 있는지 확인후 값을 스왑해줍니다.
             제일 큰값 혹은 제일 작은 값이, 배열의 맨 처음과 끝에 가도록 만들어줌..
             */
            elements.swapAt(parent, candidate)
            parent = candidate
        }
    }
    
    
    /*
     힙에 데이터 추가, remove와 반대로 배열의 맨 마지막에 값을 추가하고 siftUp하여서 값을 재 위치에 만들어줍니다.
     */
    public mutating func insert(_ element: Element) {
        elements.append(element)
        siftUp(from: elements.count - 1)
    }
    public mutating func siftUp(from index: Int) {
        var child = index
        var parent = parentIndex(ofChildAt: child)
        while child > 0 && sort(elements[child], elements[parent]) {
            elements.swapAt(child, parent)
            child = parent
            parent = parentIndex(ofChildAt: child)
        }
    }
    
    /*
     임의의 요소를 삭제하는 방법은
     1. 삭제하려는 인덱스의 존재유무 확인
     2. 삭제하려는 인덱스의 값이 범위안에 있다면, 해당 값을 맨 마지막 배열로 옮기고, 해당 값의 최대 혹은 최소값 위치 검사를 시행함
     3. 위치 검사 시행후,
     */
    public mutating func remove(at index: Int) -> Element? {
        guard index < elements.count else {
            return nil // 1
        }
        if index == elements.count - 1 {
            return elements.removeLast() // 2
        } else {
            elements.swapAt(index, elements.count - 1) // 3
            
            /*
             sift down를 사용해야하는 케이스와, sift up을 해야하는 두가지 케이스를 위해서 둘다 실행(=Heap의 조건)
             */
            defer {
                siftDown(from: index) // 5
                siftUp(from: index)
            }
            return elements.removeLast() // 4
        }
    }
}
