//
//  MSTGraph.swift
//  AdjacencyList
//
//  Created by minjuniMac on 7/19/18.
//  Copyright © 2018 com.dev.minjun. All rights reserved.
//

import Foundation

public class MSTGraph<T: Hashable & Equatable> {
    public var nodes: [MSTNode<T>]
    
    public init(nodes: [MSTNode<T>]) {
        self.nodes = nodes
    }
    
    /*
     prim 알고리즘을 구현해보자.
     MST의 실행 절차는 다음과 같다
     1. 첫번째 노드에서 출발한다. 이 노드를 출력한 뒤 visitedNodes 노드 배열에 추가한다.
     2. visitedNodes 노드 배열에서 모든 미방문 노드를 추출한다. 그리고 unvisitedEdges라는 미방문 모서리 배열을 반환 받는다
     3. 마지막으로 미방문 노드를 가리키는 모서리 배열 unvisitedEdges에서 최소 가중치인 모서리를 가져와서 minimumUnvisitedEdge에 저장 한다.이를 출력하고, 다음 최소 모서리값을 처리하기 위해 이동할 노드(unvisitedEdges.to)를 방문 노드 배열에 추가한다.
     */
    public static func minimumSpanningTree(startNode: MSTNode<T>, graph: MSTGraph<T>) {
        // 모서리 값을 처리하고 (아직은 방문하지 않은 노드의 최솟값을 선택하기 위해 방문 노드 관리용 배열을 사용합니다
        var visitedNodes: [MSTNode<T>] = []
        
        // 첫번째 노드를 출력하고, 모서리 값을 처리하기 위해 visitedNodes배열에 추가합니다.
        print(startNode.value)
        visitedNodes.append(startNode)
        startNode.visited = true
        
        // 그래프의 모든 노드를 방문할 때 까지 반복합니다.
        while visitedNodes.count < graph.nodes.count {
            // 가장 먼저 무한 반복을 피하기 위해 아직 방문하지 않은 모든 모서리를 추출 합니다
            var unvisitedEdges: [MSTEdge<T>] = []
            _ = visitedNodes.map{ (node) -> () in
                
                let edges = node.edges.filter{ (edge) -> Bool in edge.to.visited == false }
                // 방문하지 않은 모서리를 필터한후, 해당 모서리들 방문하지 않은 모서리에 업데이트
                unvisitedEdges.append(contentsOf: edges)
            }
            /*
             모서리 배열에서 가중치가 좀더 작은 것을 선택 및
             출력하고 while 루프의 다음 순회 시에도 노드를 계속
             처리할 수 있도록 visitedNode 배열에 추가합니다.
             */
            
            if let minimumUnvisitedEdge = unvisitedEdges.sorted(by: { (edgeA, edgeB) -> Bool in
                edgeA.weight < edgeB.weight}).first {
                print("\(minimumUnvisitedEdge.from.value) <--------> \(minimumUnvisitedEdge.to.value)")
                minimumUnvisitedEdge.to.visited = true
                visitedNodes.append(minimumUnvisitedEdge.to)
            }
        }
    }
}


