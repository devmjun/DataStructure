//
//  DijkstraGraph.swift
//  AdjacencyList
//
//  Created by minjuniMac on 7/19/18.
//  Copyright © 2018 com.dev.minjun. All rights reserved.
//

import Foundation

public class DijkstraGraph<T: Equatable & Hashable> {
    public var nodes: [DijkstraNode<T>]
    public init(nodes: [DijkstraNode<T>]) {
        self.nodes = nodes
    }
    /*
     1. 미방문 노드 세트를 생성(노드를 초기화하면서 무한값을 거리로 설정합니다)
     2. 현재 노드를 초기 노드로 설정합니다
     3. 각각의 미방문 이웃에 다다르기 위한 최단거리를 업데이트 합니다. 업데이트를 마치면, 기존의 노드 또한 업데이트해서 현재 노드에 이르기 위한 최단 경로를 추적하고, 현재의 노드에 방문 표식을 남깁니다.
     4. 거리값이 가장 낮은 다음 노드로 이동한 뒤, 마지막 노드를 방문할때 까지 3번 과정을 반복합니다.
     5. 마지막 노드에서 시작하는 최단 경로를 출력합니다.
     */
    
    // 다익스트라 알고리즘에 사용될 녀석.
    public static func dijkstraPath(
        startNode: DijkstraNode<T>,
        graph: DijkstraGraph<T>,
        finishNode: DijkstraNode<T>) {
        // 모든 미방문 노드를 저장하기 위한 세트를 생성
        var unvisitedNodes = Set<DijkstraNode<T>>(graph.nodes)
        
        // 방문 표식을 남기고 임시 거리로 0을 입력
        startNode.distance = 0
        
        // 현제 노드를 할당
        var currentNode: DijkstraNode<T> = startNode
        
        // 마지막 노드를 방문할 때까지 반복합니다
        while finishNode.visited == false {
            // 각각의 미방문 이웃에 대해, 현재 노드와의 거리를 계산합니다.
            for edge in currentNode.edges.filter({ $0.to.visited == false }) {
                // 현재 노드와 그 이웃 노드의 임시 거리를 계산 합니다
                let temporaryDistance = currentNode.distance + Int(edge.weight)
                
                // 임시 거리가 현재 이웃과의 거리보다 작으면,
                // 임시 거리로 업데이트 합니다. 해당 모서리의 이전 노드를 현재 노드로 업데이트 합니다.
                if edge.to.distance > temporaryDistance {
                    edge.to.distance = temporaryDistance
                    edge.to.previous = currentNode
                }
            }
            
            
            //            for edge in currentNode.edges.filter({ $0.to.visited == false }) {
            //                print("\n current: \(currentNode.value), distance: \(edge.weight), ToDistance: \(edge.to.distance), FromPrevious: \(edge.from.previous?.value), toPrevious: \(edge.to.previous?.value)")
            //            }
            
            // 노드에 방문 표식을 남깁니다.
            currentNode.visited = true
            
            // 미 방문 노드 세트에서 현재 노드를 삭제 합니다
            unvisitedNodes.remove(currentNode)
            
            // 거리가 가장 작은 순으로 정렬후, 가장 첫번째 노드를 선택.
            // 아 어차피. 거리는 무한값이고, 수정된 값이 선택되겠구나..
            // 모서리의 가중치를 계속 계산하고 수정하여서, 항상 가장 작은 값인 녀석과 다음 값인 녀석을 업데이트 하며, 최단 거리에 도달합니다.
            // 마지막 최단거리에 도달후, 최단거리에 서 이전 노드들을 방문하며, 역순으로 방문 순서를 프린트합니다.
            if let newCurrent = unvisitedNodes.sorted(by: { (nodeA, nodeB) -> Bool in
                
                nodeA.distance < nodeB.distance
            }).first {
                //                let x = unvisitedNodes.sorted(by: { (nodeA, nodeB) -> Bool in nodeA.distance < nodeB.distance })
                //                for i in x { print(i.value, i.distance) }
                
                currentNode = newCurrent
                
            }else {
                break
            }
            DijkstraGraph.printShortestPath(node: finishNode)
        }
    }
    
    // 마지막값에 기록된 이전의 값들을 거꾸로 순회하며 찾아나감..
    public static func printShortestPath(node: DijkstraNode<T>) {
        if let previous = node.previous {
            DijkstraGraph.printShortestPath(node: previous)
        }else {
            print("Shortest path: ")
        }
        print("-> \(node.value)", terminator:"")
        
    }
}

