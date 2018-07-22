import Foundation

public struct Vertex<T> {
    public let index: Int
    public let data: T
}

// Vertex는 딕셔너리의 키값으로 사용하기위해서, Hashable 프로토콜을 체택합니다.
extension Vertex: Hashable {
    public var hashValue: Int {
        return index.hashValue
    }
    public static func ==(lhs: Vertex, rhs: Vertex) -> Bool {
        return lhs.index == rhs.index
    }
}

extension Vertex: CustomStringConvertible {
    public var description: String {
        return "\(index): \(data)"
    }
}
