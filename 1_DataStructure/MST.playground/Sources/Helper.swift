import Foundation

public func example(of: String, action: () -> ()) {
    print("----------\(of)----------")
    action()
}

func processTime(blockFunction: () -> ()) {
    let startTime = CFAbsoluteTimeGetCurrent()
    
    blockFunction()
    let processTime = CFAbsoluteTimeGetCurrent() - startTime
    print("Processing Time = \(processTime)")
}
