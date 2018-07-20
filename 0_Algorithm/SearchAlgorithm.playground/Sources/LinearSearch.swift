import Foundation

// 1
/* Time Complexity O(n) */
public func linearSearch<T: Equatable>(target: T, in collection: [T]) -> T? {
    for item in collection {
        if item == target {
            return item
        }
    }
    return nil
}
