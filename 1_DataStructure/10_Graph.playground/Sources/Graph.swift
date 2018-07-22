import Foundation

public enum EdgeType {
    case directed
    case undirected
}
public protocol Graph {
    associatedtype Element
    
    // 꼭지점을 생성하고 그것을 그래프에 추가합니다.
    func createVertex(data: Element) -> Vertex<Element>
    
    //directed edge를 두개의 꼭지점 사이에 추가합니다.
    func addDirectedEdge(from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?)
    func addUndirectedEdge(between source: Vertex<Element>, and destination: Vertex<Element>, weight: Double?)
    func add(_ edge: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?)
    func edges(from source: Vertex<Element>) -> [Edge<Element>]
    func weight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double?
}

extension Graph {
    public func addUndirectedEdge(between source: Vertex<Element>,
                                  and destination: Vertex<Element>,
                                  weight: Double?) {
        // Bidirectional을 Protocol Extension을 통해서 구현..
        addDirectedEdge(from: source, to: destination, weight: weight)
        addDirectedEdge(from: destination, to: source, weight: weight)
    }
    
    public func add(_ edge: EdgeType,
                    from source: Vertex<Element>,
                    to destination: Vertex<Element>,
                    weight: Double?) {
        switch edge {
        case .directed:
            addDirectedEdge(from: source, to: destination, weight: weight)
        case .undirected:
            addUndirectedEdge(between: source, and: destination, weight: weight)
        }
    }
}

