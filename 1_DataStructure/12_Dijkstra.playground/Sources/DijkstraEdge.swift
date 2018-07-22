//
//  DijkstraEdge.swift
//  AdjacencyList
//
//  Created by minjuniMac on 7/19/18.
//  Copyright © 2018 com.dev.minjun. All rights reserved.
//

import Foundation

public class DijkstraEdge<T: Equatable & Hashable>: Equatable {
    public var from: DijkstraNode<T>
    public var to: DijkstraNode<T>
    public var weight: Double
    
    public init(weight: Double, from: DijkstraNode<T>, to: DijkstraNode<T>) {
        self.weight = weight
        self.from = from
        self.to = to
        from.edges.append(self)
    }
    
    public static func == <T: Equatable> (lhs: DijkstraEdge<T>, rhs: DijkstraEdge<T>) -> Bool {
        guard lhs.from.value == rhs.from.value else { return false }
        guard lhs.to.value == rhs.from.value else { return false }
        return true
    }
}

extension DijkstraEdge: Hashable {
    public var hashValue: Int {
        let stringHash = "\(from.value)->\(to.value)"
        return stringHash.hashValue
    }
}
