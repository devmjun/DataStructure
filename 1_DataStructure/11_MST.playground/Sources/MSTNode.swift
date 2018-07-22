//
//  File.swift
//  AdjacencyList
//
//  Created by minjuniMac on 7/19/18.
//  Copyright © 2018 com.dev.minjun. All rights reserved.
//

import Foundation

/*
 MST 알고리즘
 이번 클래스 역시(ID, 라벨을 위한) 제네릭, 모서리 배열, 그리고 특정 노드의 방문 여부를 표시하기 위한 불리언 값에 대한 변수가 포함돼 잇다.
 */

public class MSTNode<T: Equatable & Hashable> {
    // 제네릭 변수, 방문 상태 정보, 참조값 저장용 변수 선언
    public var value: T
    public var edges: [MSTEdge<T>]
    public var visited: Bool
    
    public init(value: T, edges: [MSTEdge<T>], visited: Bool) {
        self.value = value
        self.edges = edges
        self.visited = visited
    }
}


