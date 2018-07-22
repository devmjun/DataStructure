import Foundation

public func example(of: String, action: () -> () ) {
    print("\n----------\(of)----------")
    action()
}
