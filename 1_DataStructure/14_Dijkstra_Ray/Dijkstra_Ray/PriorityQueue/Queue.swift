//
//  Queue.swift
//  Dijkstra_Ray
//
//  Created by minjuniMac on 7/22/18.
//  Copyright © 2018 com.dev.minjun. All rights reserved.
//

import Foundation

public protocol Queue {
    associatedtype Element
    mutating func enqueue(_ element: Element) -> Bool
    mutating func dequeue() -> Element?
    var isEmpty: Bool { get }
    var peek: Element? { get }
}
