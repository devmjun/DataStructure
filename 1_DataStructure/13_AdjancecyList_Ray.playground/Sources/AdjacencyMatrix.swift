//
//  AdjacencyMatrix.swift
//  AdjancecyList
//
//  Created by minjuniMac on 7/21/18.
//  Copyright © 2018 com.dev.minjun. All rights reserved.
//

import Foundation

public class AdjacencyMatrix<T>: Graph {
    private var vertices: [Vertex<T>] = []
    private var weights: [[Double?]] = []
    public init() {}
    // more to come ...
    
    public func createVertex(data: T) -> Vertex<T> {
        let vertex = Vertex(index: vertices.count, data: data)
        vertices.append(vertex) // 1
        for i in 0..<weights.count { // 2
            weights[i].append(nil)
        }
        let row: [Double?] = [Double?](repeating: nil, count: vertices.count) // 3
        weights.append(row)
        return vertex
    }
    
    public func addDirectedEdge(from source: Vertex<T>,
                                to destination: Vertex<T>, weight: Double?) {
        // source 행의 destination 열의 가중치를 계산함.
        weights[source.index][destination.index] = weight
    }
    
    public func edges(from source: Vertex<T>) -> [Edge<T>] {
        var edges: [Edge<T>] = []
        for column in 0..<weights.count {
            if let weight = weights[source.index][column] {
                edges.append(Edge(
                    source: source,
                    destination: vertices[column],
                    weight: weight))
            }
        }
        return edges
    }
    
    public func weight(from source: Vertex<T>,
                       to destination: Vertex<T>) -> Double? {
        return weights[source.index][destination.index]
    }
}

extension AdjacencyMatrix: CustomStringConvertible {
    public var description: String {
        // 1
        let verticesDescription = vertices.map { "\($0)" }
        // 2
        var grid: [String] = []
        for i in 0..<weights.count {
            var row = ""
            for j in 0..<weights.count {
                if let value = weights[i][j] {
                    row += "\(value)\t"
                } else {
                    row += "ø\t\t"
                }
            }
            grid.append(row)
        }
        let edgesDescription = grid.joined(separator: "\n")
        // 3
        return "\(verticesDescription)\n\n\(edgesDescription)"
    }
}
