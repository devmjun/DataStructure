
import UIKit


example(of: "Heap sorted") {
    let heap = Heap(sort: >, elements: [6, 12, 2, 26, 8, 18, 21, 9, 5])
    print(heap.sorted())
    print(heap.elements)
}
