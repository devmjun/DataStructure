//
//  DijkstraNode.swift
//  AdjacencyList
//
//  Created by minjuniMac on 7/19/18.
//  Copyright © 2018 com.dev.minjun. All rights reserved.
//

import Foundation

public class DijkstraNode<T: Equatable & Hashable>: Equatable {
    // 값, 방문상태, 참조값 변수
    public var value: T
    public var edges: [DijkstraEdge<T>]
    public var visited: Bool
    
    // 출발지점에서 현재 노드에 이르는 최단 거리
    public var distance: Int = Int.max
    
    // 최단 경로에 이르는 기존의 노드
    // 각 노드에 이르는 경로를 각 노드의 최단 경로로 저장해야 하기 위한 변수
    public var previous: DijkstraNode<T>?
    
    public init(value: T, edges: [DijkstraEdge<T>], visited: Bool) {
        self.value = value
        self.edges = edges
        self.visited = visited
    }
    
    public static func == <T: Equatable> (lhs: DijkstraNode<T>, rhs: DijkstraNode<T>) -> Bool {
        guard lhs.value == rhs.value else { return false }
        return true
    }
}

extension DijkstraNode: Hashable {
    public var hashValue: Int {
        get {
            return value.hashValue
        }
    }
}
