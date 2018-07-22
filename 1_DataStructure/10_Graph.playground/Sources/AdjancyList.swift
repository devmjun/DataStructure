import Foundation

public class AdjacencyList<T>: Graph {
    private var adjacencies: [Vertex<T>: [Edge<T>]] = [:]
    public init() {}
    // more to come ...
    
    // 꼭지점을 생성하고 꼭지점을 adjancecies에 추가후, certex를 반환합니다.
    public func createVertex(data: T) -> Vertex<T> {
        let vertex = Vertex(index: adjacencies.count, data: data)
        adjacencies[vertex] = []
        return vertex
    }
    
    // 방향이 있는 Edge를 추가합니다(가중치도 함께 추가합니다.
    public func addDirectedEdge(from source: Vertex<T>,
                                to destination: Vertex<T>,
                                weight: Double?) {
        let edge = Edge(source: source,
                        destination: destination,
                        weight: weight)
        adjacencies[source]?.append(edge)
    }
    
    // 해당 꼭지점에서 연결되어 있는 다른꼭지점 목록들을 반환합니다.
    public func edges(from source: Vertex<T>) -> [Edge<T>] {
        return adjacencies[source] ?? []
    }
    
    // 출발점과, 도착점을 넣으면 가중치를 반환합니다.
    public func weight(from source: Vertex<T>,
                       to destination: Vertex<T>) -> Double? {
        return edges(from: source)
            .first { $0.destination == destination }?
            .weight
    }
}

// 출력 내용을 정의함.
extension AdjacencyList: CustomStringConvertible {
    public var description: String {
        var result = ""
        for (vertex, edges) in adjacencies { // 1
            var edgeString = ""
            for (index, edge) in edges.enumerated() { // 2
                if index != edges.count - 1 {
                    edgeString.append("\(edge.destination)/\(edge.weight!), ")
                } else {
                    edgeString.append("\(edge.destination)")
                }
            }
            result.append("\(vertex) ---> [ \(edgeString) ]\n") // 3
        }
        return result
    }
}
