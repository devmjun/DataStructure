//: Playground - noun: a place where people can play

import UIKit

example(of: "MST") {
    let nodeA = MSTNode(value: "A", edges: [], visited: false)
    let nodeB = MSTNode(value: "B", edges: [], visited: false)
    let nodeC = MSTNode(value: "C", edges: [], visited: false)
    let nodeD = MSTNode(value: "D", edges: [], visited: false)
    
    let edgeAB = MSTEdge(weight: 3, from: nodeA, to: nodeB)
    let edgeBA = MSTEdge(weight: 3, from: nodeB, to: nodeA)
    
    let edgeAC = MSTEdge(weight: 1, from: nodeA, to: nodeC)
    let edgeCA = MSTEdge(weight: 1, from: nodeC, to: nodeA)
    
    let edgeBC = MSTEdge(weight: 1, from: nodeB, to: nodeC)
    let edgeCB = MSTEdge(weight: 1, from: nodeC, to: nodeB)
    
    let edgeBD = MSTEdge(weight: 2, from: nodeB, to: nodeD)
    let edgeDB = MSTEdge(weight: 2, from: nodeD, to: nodeB)
    
    /*
     *     A <--3--> B <--2--> D
     *       ↖︎       ↑
     *         1     1
     *            ↘︎  ↓
     *               C
     */
    let graph = MSTGraph(nodes: [nodeA, nodeB, nodeC, nodeD])
    print(graph)
    
    /*
     A <--------> C
     C <--------> B
     B <--------> D
     */
    MSTGraph.minimumSpanningTree(startNode: nodeA, graph: graph)
}

example(of: "Modified Weighted B <-> C ") {
    let nodeA = MSTNode(value: "A", edges: [], visited: false)
    let nodeB = MSTNode(value: "B", edges: [], visited: false)
    let nodeC = MSTNode(value: "C", edges: [], visited: false)
    let nodeD = MSTNode(value: "D", edges: [], visited: false)
    
    let edgeAB = MSTEdge(weight: 3, from: nodeA, to: nodeB)
    let edgeBA = MSTEdge(weight: 3, from: nodeB, to: nodeA)
    
    let edgeAC = MSTEdge(weight: 1, from: nodeA, to: nodeC)
    let edgeCA = MSTEdge(weight: 1, from: nodeC, to: nodeA)
    
    let edgeBC = MSTEdge(weight: 100, from: nodeB, to: nodeC)
    let edgeCB = MSTEdge(weight: 100, from: nodeC, to: nodeB)
    
    let edgeBD = MSTEdge(weight: 2, from: nodeB, to: nodeD)
    let edgeDB = MSTEdge(weight: 2, from: nodeD, to: nodeB)
    
    /*
     *     A <--3--> B <--2--> D
     *       ↖︎       ↑
     *         1     100
     *            ↘︎  ↓
     *               C
     */
    let graph = MSTGraph(nodes: [nodeA, nodeB, nodeC, nodeD])
    print(graph)
    
    /*
     A <--------> C
     A <--------> B
     B <--------> D
     */
    MSTGraph.minimumSpanningTree(startNode: nodeA, graph: graph)
}



