//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

example(of: "Dijkstra") {
    processTime {
        let nodeA = DijkstraNode(value: "A", edges: [], visited: false)
        let nodeB = DijkstraNode(value: "B", edges: [], visited: false)
        let nodeC = DijkstraNode(value: "C", edges: [], visited: false)
        let nodeD = DijkstraNode(value: "D", edges: [], visited: false)
        let nodeE = DijkstraNode(value: "E", edges: [], visited: false)
        let nodeF = DijkstraNode(value: "F", edges: [], visited: false)
        let nodeG = DijkstraNode(value: "G", edges: [], visited: false)
        let nodeH = DijkstraNode(value: "H", edges: [], visited: false)
        let nodeI = DijkstraNode(value: "I", edges: [], visited: false)
        
        let edgeAB = DijkstraEdge(weight: 1, from: nodeA, to: nodeB)
        let edgeBA = DijkstraEdge(weight: 1, from: nodeB, to: nodeA)
        
        let edgeBC = DijkstraEdge(weight: 5, from: nodeB, to: nodeC)
        let edgeCB = DijkstraEdge(weight: 5, from: nodeC, to: nodeB)
        
        let edgeCF = DijkstraEdge(weight: 20, from: nodeC, to: nodeF)
        let edgeFC = DijkstraEdge(weight: 20, from: nodeF, to: nodeC)
        
        let edgeBD = DijkstraEdge(weight: 7, from: nodeB, to: nodeD)
        let edgeDB = DijkstraEdge(weight: 7, from: nodeD, to: nodeB)
        
        let edgeDE = DijkstraEdge(weight: 1, from: nodeD, to: nodeE)
        let edgeED = DijkstraEdge(weight: 1, from: nodeE, to: nodeD)
        
        let edgeDH = DijkstraEdge(weight: 2, from: nodeD, to: nodeH)
        let edgeHD = DijkstraEdge(weight: 2, from: nodeH, to: nodeD)
        
        let edgeHI = DijkstraEdge(weight: 1, from: nodeH, to: nodeI)
        let edgeIH = DijkstraEdge(weight: 1, from: nodeI, to: nodeH)
        
        let edgeIF = DijkstraEdge(weight: 1, from: nodeI, to: nodeF)
        let edgeFI = DijkstraEdge(weight: 1, from: nodeF, to: nodeI)
        
        let edgeEF = DijkstraEdge(weight: 4, from: nodeE, to: nodeF)
        let edgeFE = DijkstraEdge(weight: 4, from: nodeF, to: nodeE)
        
        let edgeFG = DijkstraEdge(weight: 2, from: nodeF, to: nodeG)
        let edgeGF = DijkstraEdge(weight: 2, from: nodeG, to: nodeF)
        
        let graph = DijkstraGraph(nodes: [nodeA, nodeB, nodeC, nodeD,
                                          nodeE, nodeF, nodeG, nodeH, nodeI])
    
        DijkstraGraph.dijkstraPath(startNode: nodeA, graph: graph, finishNode: nodeG)
    }
}

example(of: "Modified Path") {
    let nodeA = DijkstraNode(value: "A", edges: [], visited: false)
    let nodeB = DijkstraNode(value: "B", edges: [], visited: false)
    let nodeC = DijkstraNode(value: "C", edges: [], visited: false)
    let nodeD = DijkstraNode(value: "D", edges: [], visited: false)
    let nodeE = DijkstraNode(value: "E", edges: [], visited: false)
    let nodeF = DijkstraNode(value: "F", edges: [], visited: false)
    let nodeG = DijkstraNode(value: "G", edges: [], visited: false)
    let nodeH = DijkstraNode(value: "H", edges: [], visited: false)
    
    let edgeAB = DijkstraEdge(weight: 8, from: nodeA, to: nodeB)
    
    let edgeAF = DijkstraEdge(weight: 9, from: nodeA, to: nodeF)
    let edgeFA = DijkstraEdge(weight: 2, from: nodeF, to: nodeA)
    
    let edgeAG = DijkstraEdge(weight: 1, from: nodeA, to: nodeG)
    
    let edgeHG = DijkstraEdge(weight: 5, from: nodeH, to: nodeG)
    let edgeHF = DijkstraEdge(weight: 2, from: nodeH, to: nodeF)
    
    let edgeGC = DijkstraEdge(weight: 3, from: nodeG, to: nodeC)
    
    let edgeBE = DijkstraEdge(weight: 1, from: nodeB, to: nodeE)
    
    let edgeCB = DijkstraEdge(weight: 3, from: nodeC, to: nodeB)
    let edgeCE = DijkstraEdge(weight: 1, from: nodeC, to: nodeE)
    let nodeEC = DijkstraEdge(weight: 8, from: nodeE, to: nodeC)
    
    let edgeED = DijkstraEdge(weight: 2, from: nodeE, to: nodeD)
    
    let graph = DijkstraGraph(nodes: [nodeA, nodeB, nodeC, nodeD,
                                      nodeE, nodeF, nodeG, nodeH])
    
    DijkstraGraph.dijkstraPath(startNode: nodeA, graph: graph, finishNode: nodeD)
}


