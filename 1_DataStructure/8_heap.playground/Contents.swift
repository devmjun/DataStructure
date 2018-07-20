import UIKit

example(of: "Defer Test") {
    func deferTest() -> String {
        print("함수 진입")
        defer { print("함수문 안의 디퍼문") }
        return "함수의 반환값"
    }
    
    print("함수 호출전")
    print(deferTest())
    print("함수 호출 후")
    
}

example(of: "Remove") {
  
    // 이미 heap 으로 만들어질때, siftdown을 통해서 제일 큰 값과 작은 값을 맨 위 또는 아래로 변경
    var heap = Heap(sort: >, elements: [1,12,9,4,1,6,8,7])
    while !heap.isEmpty {
        print("삭제후 반환값, heap.remove()!: \(heap.remove()!)")
    }
}

example(of: "Remove Arbitrary") {
    var heap = Heap(sort: >, elements: [1,12,9,4,1,6,8,7])
    print(heap.remove(at: 2))
}

example(of: "Initilazerd") {
    var heap = Heap(sort: <, elements: [1,12,9,4,1,6,8,7])
    print(heap.elements)
    
}
