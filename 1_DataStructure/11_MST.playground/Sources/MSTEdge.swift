//
//  MSEdge.swift
//  AdjacencyList
//
//  Created by minjuniMac on 7/19/18.
//  Copyright © 2018 com.dev.minjun. All rights reserved.
//

import Foundation

/*
 MSTEdge 모서리 클래스
 */
public class MSTEdge<T: Equatable & Hashable> {
    public var from: MSTNode<T>
    public var to: MSTNode<T>
    public var weight: Double
    
    public init(weight: Double, from: MSTNode<T>, to: MSTNode<T>) {
        self.weight = weight
        self.from = from
        self.to = to
        
        // 모서리에, 각 노드들 추가하고, 해당 노드의 모서리를 추가함..
        // 이 방법은 개인적으로 좋지 않다고 생각함.. Node도 모서리를 가지고 있고, 모서리도 Node를 가지고 있으니 RetainCycle 발생.. 좀더 고민 해보고 다른 좋은 방법 있나 생각해보자
        from.edges.append(self)
    }
    
    // from 과 to의 Value 가 같으면, 같은 모서리를 가졌다고 할수 있음.
    public static func == <T: Equatable> (lhs: MSTEdge<T>, rhs: MSTEdge<T>) -> Bool {
        guard lhs.from.value == rhs.from.value else { return false }
        guard lhs.to.value == rhs.to.value else { return false }
        return true
    }
}

extension MSTEdge: Hashable {
    public var hashValue: Int {
        get {
            let stringHash = "\(from.value)->\(to.value)"
            return stringHash.hashValue
        }
    }
}

