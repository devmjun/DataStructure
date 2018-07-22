//
//  Dijkstra.swift
//  Dijkstra_Ray
//
//  Created by minjuniMac on 7/22/18.
//  Copyright © 2018 com.dev.minjun. All rights reserved.
//

import Foundation

public enum Visit<T: Hashable> {
    // 1. 꼭지점은 시작하는 꼭지점입니다
    case start
    
    // 2. 꼭지점에는 되돌아 가는 경로로 이어지는 연관된 모서리들이 있습니다
    case edge(Edge<T>)
}

public class Dijkstra<T: Hashable> {
    public typealias Graph = AdjacencyList<T>
    let graph: Graph
    public init(graph: Graph) { self.graph = graph }
    
    /*
     역 경로 추적을 할수 있는 도우미 함수.
     이 메소드는 기존 경로의 딕셔너리와 함께 목적지 꼭지점을 가져와서 목적지 꼭지점으로 연결되는 경로를 구성합니다. 코드를 살펴봅니다.
     
     1. 목적지 꼭지점에서 시작합니다
     2. 모서리 배열을 생성하고 경로를 저장합니다.
     3. 출발점 케이스(source case)에 도달하지 않는다면, 계속해서 다음 모서리를 추출합니다.
     4. 이 모서리를 경로에 추가합니다.
     5. 현재꼭지점에서 모서리의 도착점 꼭지점으로 세팅합니다. 그러면 시작점에 가까워 집니다.
     6. while 반복문을 시작 케이스에 도달하고 해당 경로를 완료하고 그것을 반환합니다.
     */
    private func route(to destination: Vertex<T>,
                       with paths: [Vertex<T> : Visit<T>]) -> [Edge<T>] {
        // 1. 목적지 꼭지점을 지정합니다.
        var vertex = destination
        
        // 2. 모서리 배열을 Path에 저장합니다.
        var path: [Edge<T>] = []
        
        // 3. 출발점에 도달할떄까지 계속 다음 케이스를 추출합니다.
        while let visit = paths[vertex], case .edge(let edge) = visit { // 3
            path = [edge] + path // 4
            
            // 5. 현재꼭지점에서, 모서리의
            vertex = edge.source // 5
        }
        return path // 6
    }
    
    // 도착지에서 최종 경로에 도달하게 되었을때 가중치를 계산하기 위한 메소드.
    private func distance(to destination: Vertex<T>,
                          with paths: [Vertex<T> : Visit<T>]) -> Double {
        // 목적지와, [꼭지점:모서리] 목록을 넣으면,
        let path = route(to: destination, with: paths) // 1
        let distances = path.flatMap { $0.weight } // 2
        return distances.reduce(0.0, +) // 3
    }
    
    // 다익 스트라 알고리즘
    public func shortestPath(from start: Vertex<T>) -> [Vertex<T> : Visit<T>] {
        // 1. Paths에 시작지점을 초기화합니다.
        var paths: [Vertex<T> : Visit<T>] = [start: .start]
        
        // 2.
        var priorityQueue = PriorityQueue<Vertex<T>>(sort: {
            self.distance(to: $0, with: paths) < self.distance(to: $1, with: paths)
        })
        priorityQueue.enqueue(start) // 3
        // to be continued
        
        // 현재 우선순위 큐에 들어있는 꼭지점을 넣어줍니다.
        while let vertex = priorityQueue.dequeue() {
            
            // 현재꼭지점의 모서리 목록들을 순회합니다.
            for edge in graph.edges(from: vertex) {
                
                // 해당 모서리의 가중치를 저장합니다.
                guard let weight = edge.weight else { continue }
                
                // 현재 꼭지점의 모서리에 있는 도착점에 방문을 하지 않았거나, 출발점에서 현재꼭지점 까지의 가중치가 < 목적지의 가중치보다 작으면
                if paths[edge.destination] == nil || distance(to: vertex, with: paths) + weight < distance(to: edge.destination, with: paths) { // 4
                    // Paths 목록에 현재 꼭지점에서 다른목적지에 모서리를 추가하고,
                    paths[edge.destination] = .edge(edge)
                    
                    // 해당 꼭지점을 우선순위큐에 넣습니다.
                    priorityQueue.enqueue(edge.destination)
                }
            }
        }
        
        
        return paths
    }
    
    public func shortestPath(to destination: Vertex<T>,
                             paths: [Vertex<T> : Visit<T>]) -> [Edge<T>] {
        return route(to: destination, with: paths)
    }
}
