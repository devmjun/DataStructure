//
//  Vertex.swift
//  Dijkstra_Ray
//
//  Created by minjuniMac on 7/22/18.
//  Copyright © 2018 com.dev.minjun. All rights reserved.
//

import Foundation

public struct Vertex<T> {
    
    public let index: Int
    public let data: T
}

extension Vertex: Hashable {
    
    public var hashValue: Int {
        return index.hashValue
    }
    
    public static func ==(lhs: Vertex, rhs: Vertex) -> Bool {
        return lhs.index == rhs.index
    }
}

extension Vertex: CustomStringConvertible {
    public var description: String {
        return "\(data)"
    }
}
