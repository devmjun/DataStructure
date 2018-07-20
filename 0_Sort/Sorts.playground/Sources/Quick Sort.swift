import Foundation

/*
 Easy to understand but not very efficient.
 */
public func quicksort<T: Comparable>(_ a: [T]) -> [T] {
    guard a.count > 1 else { return a }
    
    let pivot = a[a.count/2]
    let less = a.filter { $0 < pivot }
    let equal = a.filter { $0 == pivot }
    let greater = a.filter { $0 > pivot }
    print("\nArray: \(a) \nless: \(less) \nequal: \(equal) \ngreater: \(greater)\nresult:\(less+equal+greater)")
    
    return quicksort(less) + equal + quicksort(greater)
}
