//
//  Helper.swift
//  Dijkstra_Ray
//
//  Created by minjuniMac on 7/22/18.
//  Copyright © 2018 com.dev.minjun. All rights reserved.
//

import Foundation

public func processTime(action:() -> () ) {
    let startTime = CFAbsoluteTimeGetCurrent()
    action()
    let processingTime = CFAbsoluteTimeGetCurrent() - startTime
    print("ProcessingTime is \(processingTime)")
}

public func example(of: String, action: () ->() ) {
    print("--------\(of)----------")
    action()
}
