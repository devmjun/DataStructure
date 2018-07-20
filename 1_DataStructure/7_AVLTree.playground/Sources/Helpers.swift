
import Foundation

public func example(of description: String, action: () -> Void) {
  print("---Example of: \(description)---")
  action()
  print()
}

public func processTime(of: String, action: () -> ()) {
    var startTime = CFAbsoluteTimeGetCurrent()
    action()
    let processingTime = CFAbsoluteTimeGetCurrent() - startTime
    print("\(of), processing Time is \(processingTime)")
}
