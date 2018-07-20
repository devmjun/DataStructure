import Foundation

/* Time complexity O(log n) */

public func binarySearch<T: Comparable>(target: T, in collection:[T]) -> T? {
    
    var data = collection.sorted()
    // BinarySearch는 collection이 Sort되어있어야함!
    print(data)
    
    var startIndex: Int = 0
    var endIndex: Int = data.count-1
    while startIndex <= endIndex {
        var midIndex: Int = (startIndex + endIndex) / 2
        if data[midIndex] == target {
            return target
        }else if data[midIndex] < target {
            startIndex = midIndex + 1
        }else if data[midIndex] > target {
            endIndex = midIndex - 1
        }
    }
    return nil
}
