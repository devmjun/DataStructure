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

public func createRandomArray(numberOfElements: Int = 10) -> [Int] {
    var randomIntInArray: [Int] = [Int]()
    while randomIntInArray.count != numberOfElements {
        let popRandomValue = Int(arc4random_uniform(11))
        randomIntInArray.append(popRandomValue)
    }
    return randomIntInArray
}
