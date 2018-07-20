import Foundation

public func processTime(blockFunction: () -> ()) {
    let startTime = CFAbsoluteTimeGetCurrent()
    blockFunction()
    let processTime = CFAbsoluteTimeGetCurrent() - startTime
    print("Processing Time = \(processTime)")
}

public func example(of: String, isAction: Bool = true, action: () -> Void) {
    print("\n ---------\(of), isAction: \(isAction)---------")
    
    if isAction {
        action()
    }
}
